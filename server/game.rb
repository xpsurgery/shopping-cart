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
      fine_for_late_attempt: 0,
      fine_for_tax_error: 300,
      fine_for_missing_discount: 50,
      fine_for_incorrect: 500
    },
    regions: {
      BE: {
        sales_tax: 8.25,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      FR: {
        sales_tax: 6.25,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      IT: {
        sales_tax: 6.85,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      ES: {
        sales_tax: 8.00,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      NL: {
        sales_tax: 4.00,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      }
    }
  })

  def initialize
    @challenges = Hashie::Mash.new
    @config = DEFAULTS
    setup(DEFAULTS)
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

  def issue_challenge
    timestamp = Time.now
    id = '1234'
    challenge = Hashie::Mash.new({
      id: id,
      issuedAt: timestamp,
      expiresAt: timestamp + @config.sales.expiry_secs
    })
    @challenges[id] = challenge
    challenge
  end

  def answer(id, payload, on_success, on_error)
    errors = []
    errors << 'Please wait until the game is in progress' if @phase != :playing
    errors << 'Please supply your team name' unless payload.teamName
    if @challenges.has_key?(id)
      challenge = @challenges[id]
      errors << "Challenge #{id} has timed out" if Time.now < challenge.expiresAt
    else
      errors << "No challenge with id #{id} has been issued" unless @challenges.has_key?(id)
    end

    if errors.empty?
      on_success.call
    else
      on_error.call(Hashie::Mash.new({
        errors: errors
      }))
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

