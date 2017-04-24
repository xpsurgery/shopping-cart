require 'hashie/mash'

class Game

  DEFAULTS = Hashie::Mash.new({
    initial_balance: 10000,
    payroll: {
      interval_secs: 60,
      wage_bill: 100
    },
    sales: {
      expiry_secs: 3,
      commission: 500,
      fine_for_expiry: 0,
      fine_for_tax_error: 300,
      fine_for_missing_discount: 50,
      fine_for_incorrect: 500
    }
  })

  def initialize
    @config = DEFAULTS
    setup(DEFAULTS)
  end

  def setup(config)
    @config = @config.merge(config)
    @phase = :setup
    @teams = []
  end

  def add_team(name)
    return false unless @phase == :setup
    @teams << Hashie::Mash.new({
      id:           @teams.length + 1,
      name:         name,
      cash_balance: @config.initial_balance
    })
    true
  end

  def run_payroll
    @teams.each do |team|
      team.cash_balance = [team.cash_balance - @config.payroll.wage_bill, 0].max
    end
  end

  def play
    @payroll_thread = Thread.new do
      loop do
        sleep @config.payroll.interval_secs
        run_payroll
      end
    end
    @phase = :playing
  end

  def pause
    @payroll_thread.kill
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

