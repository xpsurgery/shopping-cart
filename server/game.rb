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
    },
    regional_taxes: {
      BE: 8.25,
      FR: 6.25,
      IT: 6.85,
      ES: 8.00,
      NL: 4.00
    },
    discount_bands: [
      { total_less_than: 1000, discount: 0.00 },
      { total_less_than: 5000, discount: 0.03 },
      { total_less_than: 7000, discount: 0.05 },
      { discount: 0.085 },
    ]
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

  def issue_challenge
    Hashie::Mash.new({
      id: '1234'
    })
  end

  def answer(id, payload, on_success, on_error)
    if @phase != :playing
      on_error.call(Hashie::Mash.new({
        errors: ['Please wait until the game is in progress']
      }))
      return
    end
    unless payload.teamName
      on_error.call(Hashie::Mash.new({
        errors: ['Please supply your team name']
      }))
      return
    end
    on_error.call(Hashie::Mash.new({
      errors: ["No challenge with id #{id} has been issued"]
    }))
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

