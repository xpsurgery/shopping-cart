class Game

  def initialize
    setup
  end

  def setup
    @phase = :setup
    @teams = []
  end

  def add_team(name)
    return false unless @phase == :setup
    @teams << {
      id:      @teams.length + 1,
      name:    name,
      balance: 1000000
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
      phase: @phase,
      teams: @teams
    }
  end

end

