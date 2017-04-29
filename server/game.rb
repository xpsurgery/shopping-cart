require 'hashie/mash'
require_relative './config'
require_relative './challenges'

class Game

  def initialize
    @config = Config::DEFAULTS
    setup(Config::DEFAULTS)
    @challenges = Challenges.new(@config)
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

  def challenge
    @challenges
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

