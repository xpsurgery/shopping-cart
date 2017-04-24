class Game

  attr_reader :teams

  def initialize
    setup
  end

  def setup
    @phase = :setup
    @teams = []
  end

  def add_team(name)
    content_type :json
    @teams << {
      id:      @teams.length + 1,
      name:    name,
      balance: 1000000
    }
  end

  def play
    @phase = :playing
    @teams
  end

  def pause
    @phase = :analysing
  end

end

