require 'json'

module AdminApi

  def self.registered(app)

    app.post '/start' do
      content_type :json
      result = app.settings.game.start
      [result[0], JSON.pretty_generate(result[1].merge({self: request.fullpath}))]
    end

    app.post '/teams' do
      content_type :json
      request.body.rewind
      payload = JSON.parse(request.body.read.strip, symbolize_names: true)
      result = app.settings.game.add_team(payload)
      [result[0], JSON.pretty_generate(result[1].merge({self: request.fullpath}))]
    end

    app.post '/configure' do
      content_type :json
      request.body.rewind
      payload = request.body.read.strip
      config = payload.empty? ? {} : JSON.parse(payload, symbolize_names: true)
      result = app.settings.game.configure(config)
      [result[0], JSON.pretty_generate(result[1].merge({self: request.fullpath}))]
    end

    app.post '/play' do
      content_type :json
      result = app.settings.game.play
      [result[0], JSON.pretty_generate(result[1].merge({self: request.fullpath}))]
    end

    app.post '/pause' do
      content_type :json
      result = app.settings.game.pause
      [result[0], JSON.pretty_generate(result[1].merge({self: request.fullpath}))]
    end

    app.post '/restart' do
      content_type :json
      result = app.settings.game.restart
      [result[0], JSON.pretty_generate(result[1].merge({self: request.fullpath}))]
    end

    app.get '/status' do
      content_type :json
      [200, JSON.pretty_generate(app.settings.game.status)]
    end

  end

end

