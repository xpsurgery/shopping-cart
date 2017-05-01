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
    response = challenge.challenge
    @challenges[response.id] = challenge
    response
  end

  def answer(id, payload, on_success, on_error)
    unless payload.teamName
      error = 'Please supply your team name'
      return on_error.call(Hashie::Mash.new({ errors: [error], penalty: 0 }))
    end
    team = @teams[payload.teamName]
    if team == nil
      error = "Unknown team '#{payload.teamName}'"
      return on_error.call(Hashie::Mash.new({ errors: [error], penalty: 0 }))
    end
    unless @challenges.has_key?(id)
      error = "No challenge with id #{id} has been issued" unless @challenges.has_key?(id)
      return on_error.call(Hashie::Mash.new({ errors: [error], penalty: 0 }))
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

    commission = @config.sales.commission
    team.cash_balance = team.cash_balance + commission
    result = Hashie::Mash.new({
      income: commission
    })

    on_success.call(result)
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

