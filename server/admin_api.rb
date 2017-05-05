require 'json'

module AdminApi

  def self.registered(app)

    app.post '/setup' do
      content_type :json
      request.body.rewind
      payload = request.body.read.strip
      config = payload.empty? ? {} : JSON.parse(payload, symbolize_names: true)
      app.settings.game.setup(config)
      [200, JSON.pretty_generate(app.settings.game.status)]
    end

    app.post '/teams' do
      content_type :json
      request.body.rewind
      payload = JSON.parse(request.body.read.strip, symbolize_names: true)
      if app.settings.game.add_team(payload[:name])
        [200, JSON.pretty_generate(app.settings.game.status)]
      else
        [400, JSON.pretty_generate({
          errors: 'Too late, the game has already begun'
        })]
      end
    end

    app.post '/play' do
      content_type :json
      app.settings.game.play
      [200, JSON.pretty_generate(app.settings.game.status)]
    end

    app.get '/status' do
      content_type :json
      [200, JSON.pretty_generate(app.settings.game.status)]
    end

    app.post '/pause' do
      content_type :json
      app.settings.game.pause
      [200, JSON.pretty_generate(app.settings.game.status)]
    end

  end

end

