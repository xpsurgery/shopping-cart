require 'json'

module Api

  def self.registered(app)

    app.post '/start' do
      content_type :json
      gameState.phase = 'adding-teams'
      [200, JSON.pretty_generate(gameState)]
    end

    app.post '/teams' do
      content_type :json
      gameState.teams << {
        id: request.payload.id,
        name: request.payload.name,
        posUrl: null,
        lastResponse: null,
        balance: 1000000
      }
      [200, JSON.pretty_generate(gameState)]
    end

    app.post '/play' do
      content_type :json
      gameState.phase = 'playing'
      [200, JSON.pretty_generate(gameState)]
    end

    app.get '/game' do
      content_type :json
      [200, JSON.pretty_generate(gameState)]
    end

    app.post '/cease' do
      content_type :json
      gameState.phase = 'analysing'
      [200, JSON.pretty_generate(gameState)]
    end

  end

end

