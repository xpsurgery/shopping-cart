require 'json'

module Api

  def self.registered(app)

    app.post '/start' do
      content_type :json
      app.settings.game.setup
      [200, JSON.pretty_generate(app.settings.game.teams)]
    end

    app.post '/teams' do
      content_type :json
      if app.settings.game.phase != :setup
        return [400, JSON.pretty_generate({
          errors: 'Too late, the game has already begun'
        })]
      end
      app.settings.game.add_team(name)
      [200, JSON.pretty_generate(app.settings.game.teams)]
    end

    app.post '/play' do
      content_type :json
      [200, JSON.pretty_generate(app.settings.game.play)]
    end

    app.get '/teams' do
      content_type :json
      [200, JSON.pretty_generate(app.settings.game.teams)]
    end

    app.post '/pause' do
      content_type :json
      app.settings.game.pause
      [200, JSON.pretty_generate(app.settings.game.teams)]
    end

  end

end

