class Game

  DEFAULTS = {
    initial_balance: 10000,
    payroll: {
      interval_secs: 60,
      wage_bill: 100
    }
  }

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
    @teams << {
      id:      @teams.length + 1,
      name:    name,
      balance: @config[:initial_balance]
    }
    true
  end

  def play
    @phase = :playing
  end

  def pause
    @phase = :analysing
  end

  def status
    {
      config: @config,
      phase: @phase,
      teams: @teams
    }
  end

end

