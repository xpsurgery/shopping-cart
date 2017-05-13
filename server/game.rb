require 'hashie/mash'
require_relative './challenge'
require_relative './config'
require_relative './randomiser'

class Game

  def initialize
    start
  end

  def start
    return [400, {errors: 'Action not permitted at this time'}] if @phase == :playing
    @config = Config::DEFAULTS
    @teams = Hashie::Mash.new
    @challenges = Hashie::Mash.new
    @phase = :setup
    [200, status]
  end

  def add_team(details)
    errors = []
    errors << 'Action not permitted at this time' unless @phase == :setup
    name = details[:name]
    errors << 'Please supply a team name' unless name && name.strip.length > 0
    errors << "Team name '#{name}' already in use" if @teams.has_key?(name)
    colour = details[:colour]
    errors << 'Please supply a team colour' unless colour && colour.strip.length > 0
    return [400, {errors: errors}] unless errors.empty?
    @teams[name] = Hashie::Mash.new({
      id:           @teams.keys.length + 1,
      name:         name,
      colour:       colour,
      cash_balance: 0
    })
    [200, status]
  end

  def configure(config)
    return [400, {errors: 'Action not permitted at this time'}] unless @phase == :setup
    @config = @config.merge(config)
    @teams.each do |_, team|
      team.cash_balance = @config.initial_balance
    end
    @phase = :paused
    [200, status]
  end

  def run_payroll
    @teams.each do |_, team|
      team.cash_balance = [team.cash_balance - @config.payroll.wage_bill, 0].max
    end
  end

  def play(run_payroll  = true)
    return [400, {errors: 'Action not permitted at this time'}] unless @phase == :paused
    if run_payroll
      @payroll_thread = Thread.new do
        loop do
          sleep @config.payroll.interval_secs
          run_payroll
        end
      end
    end
    @phase = :playing
    [200, status]
  end

  def issue(timestamp = Time.now)
    challenge = Challenge.new(@config, Randomiser.new(@config.regions.keys), timestamp)
    @challenges[challenge.id] = challenge
    challenge
  end

  def answer(id, payload, on_success, on_error)
    result = Hashie::Mash.new({
      penalties: { }
    })
    errors = []
    if payload.teamName
      team = @teams[payload.teamName]
      if team
        result.team = team
      else
        errors << "Unknown team '#{payload.teamName}'"
      end
    else
      errors << 'Please supply your team name'
    end
    unless @challenges.has_key?(id)
      errors << "No challenge with id #{id} has been issued" unless @challenges.has_key?(id)
    end
    unless errors.empty?
      result.errors = errors
      return on_error.call(result)
    end

    challenge = @challenges[id]
    result.challenge = challenge.challenge

    if Time.now >= challenge.challenge.expiresAt
      penalty = @config.sales.penalty_for_late_attempt
      team.cash_balance = team.cash_balance - penalty
      result.errors = ["Challenge #{id} has timed out"]
      result.penalties = { challengeExpired: penalty }
      return on_error.call(result)
    end

    unless payload.answer
      result.errors = ['Please supply an answer to the challenge']
      return on_error.call(result)
    end

    valid_responses = challenge.valid_responses

    if payload.answer == valid_responses.correct
      commission = @config.sales.commission
      team.cash_balance = team.cash_balance + commission
      result.income = commission
      return on_success.call(result)
    end

    if payload.answer == valid_responses.tax_but_no_discount
      commission = @config.sales.commission
      penalty = @config.sales.penalty_for_missing_discount
      team.cash_balance = team.cash_balance + commission - penalty
      result.income = commission
      result.penalties = { missing_discount: penalty }
      return on_success.call(result)
    end

    if payload.answer == valid_responses.discount_but_no_tax
      commission = @config.sales.commission
      penalty = @config.sales.penalty_for_missing_tax
      team.cash_balance = team.cash_balance + commission - penalty
      result.income = commission
      result.penalties = { missing_tax: penalty }
      return on_success.call(result)
    end

    if payload.answer == valid_responses.no_tax_or_discount
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
    result.errors = ['Incorrect answer']
    result.penalties = { incorrectAnswer: penalty }
    return on_error.call(result)
  end

  def pause
    return [400, {errors: 'Action not permitted at this time'}] unless @phase == :playing
    @payroll_thread.kill if @payroll_thread
    @phase = :paused
    [200, status]
  end

  def status
    Hashie::Mash.new({
      config: @config,
      phase: @phase,
      teams: @teams
    })
  end

end

