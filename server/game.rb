require 'hashie/mash'
require_relative './challenge'
require_relative './config'
require_relative './randomiser'

class Game

  def initialize
    @config = Config::DEFAULTS
    setup(Config::DEFAULTS)
    @challenges = Hashie::Mash.new
  end

  def setup(config)
    @config = @config.merge(config)
    @phase = :setup
    @teams = Hashie::Mash.new
  end

  def add_team(name)
    return false unless @phase == :setup
    @teams[name] = Hashie::Mash.new({
      id:           @teams.keys.length + 1,
      name:         name,
      cash_balance: @config.initial_balance
    })
    true
  end

  def run_payroll
    @teams.each do |_, team|
      team.cash_balance = [team.cash_balance - @config.payroll.wage_bill, 0].max
    end
  end

  def play(run_payroll  = true)
    if run_payroll
      @payroll_thread = Thread.new do
        loop do
          sleep @config.payroll.interval_secs
          run_payroll
        end
      end
    end
    @phase = :playing
  end

  def issue(timestamp = Time.now)
    challenge = Challenge.new(@config, Randomiser.new(@config.regions.keys), timestamp)
    @challenges[challenge.id] = challenge
    challenge
  end

  def answer(id, payload, on_success, on_error)
    unless payload.teamName
      error = 'Please supply your team name'
      return on_error.call(Hashie::Mash.new({ errors: [error], penalty: 0 }))
    end
    errors = []
    team = @teams[payload.teamName]
    if team == nil
      errors << "Unknown team '#{payload.teamName}'"
    end
    unless @challenges.has_key?(id)
      errors << "No challenge with id #{id} has been issued" unless @challenges.has_key?(id)
    end
    unless errors.empty?
      return on_error.call(Hashie::Mash.new({ errors: errors, penalty: 0 }))
    end

    challenge = @challenges[id]
    if Time.now >= challenge.challenge.expiresAt
      penalty = @config.sales.penalty_for_late_attempt
      team.cash_balance = team.cash_balance - penalty
      error = "Challenge #{id} has timed out"
      return on_error.call(Hashie::Mash.new({ errors: [error], penalty: penalty }))
    end
    unless payload.answer
      error = 'Please supply an answer to the challenge'
      return on_error.call(Hashie::Mash.new({ errors: [error], penalty: 0 }))
    end

    valid_responses = challenge.valid_responses

    if payload.answer == valid_responses.correct
      result = Hashie::Mash.new({ })
      commission = @config.sales.commission
      team.cash_balance = team.cash_balance + commission
      result.income = commission
      return on_success.call(result)
    end

    if payload.answer == valid_responses.tax_but_no_discount
      result = Hashie::Mash.new({ })
      commission = @config.sales.commission
      penalty = @config.sales.penalty_for_missing_discount
      team.cash_balance = team.cash_balance + commission - penalty
      result.income = commission
      result.penalties = { missing_discount: penalty }
      return on_success.call(result)
    end

    if payload.answer == valid_responses.discount_but_no_tax
      result = Hashie::Mash.new({ })
      commission = @config.sales.commission
      penalty = @config.sales.penalty_for_missing_tax
      team.cash_balance = team.cash_balance + commission - penalty
      result.income = commission
      result.penalties = { missing_tax: penalty }
      return on_success.call(result)
    end

    if payload.answer == valid_responses.no_tax_or_discount
      result = Hashie::Mash.new({ })
      commission = @config.sales.commission
      penalty1 = @config.sales.penalty_for_missing_tax
      penalty2 = @config.sales.penalty_for_missing_discount
      team.cash_balance = team.cash_balance + commission - penalty1 - penalty2
      result.income = commission
      result.penalties = {
        missing_tax: penalty1,
        missing_discount: penalty2
      }
      return on_success.call(result)
    end

    penalty = @config.sales.penalty_for_incorrect
    team.cash_balance = team.cash_balance - penalty
    error = 'Incorrect answer'
    return on_error.call(Hashie::Mash.new({ errors: [error], penalty: penalty }))
  end

  def pause
    @payroll_thread.kill if @payroll_thread
    @phase = :analysing
  end

  def status
    Hashie::Mash.new({
      config: @config,
      phase: @phase,
      teams: @teams
    })
  end

end

