require 'hashie/mash'
require_relative './config'

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
    id = '1234'                                              # TODO
    region_name = 'ES'
    region = @config.regions[region_name]
    num_items = 5
    unit_price = 10
    response = Hashie::Mash.new({
      id: id,
      region: region_name,
      numberOfItems: num_items,
      unitPrice: unit_price,
      issuedAt: timestamp,
      expiresAt: timestamp + @config.sales.expiry_secs
    })
    basic = num_items * unit_price
    @challenges[id] = response.merge({
      valid_responses: {
        correct: 34,
        tax_but_no_discount: 34,
        discount_but_no_tax: 34,
        no_tax_or_discount: basic
      }
    })
    response
  end

  def answer(id, payload, on_success = nil, on_error = nil)
    errors = []
    if payload.teamName
      team = @teams[payload.teamName]
      if team == nil
        errors << "Unknown team '#{payload.teamName}'"
      elsif @challenges.has_key?(id)
        challenge = @challenges[id]
        if Time.now >= challenge.expiresAt
          team.cash_balance = team.cash_balance - @config.sales.fine_for_late_attempt
          errors << "Challenge #{id} has timed out. You have been fined #{@config.sales.fine_for_late_attempt}."
        end
      else
        errors << "No challenge with id #{id} has been issued" unless @challenges.has_key?(id)
      end
    else
      errors << 'Please supply your team name'
    end

    if errors.empty?
      on_success.call({}) if on_success
    else
      on_error.call(Hashie::Mash.new({
        errors: errors
      })) if on_error
    end
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

