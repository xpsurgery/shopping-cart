require 'json'

module PlayerApi

  def self.registered(app)

    app.get '/challenge' do
      content_type :json
      host = request.fullpath.gsub(/\/challenge$/, '')
      challenge = app.settings.game.issue.challenge.merge({
        postResponseTo: "#{host}/answer/#{challenge.id}"
      })
      [200, JSON.pretty_generate(challenge)]
    end

    app.post '/answer/:id' do
      content_type :json
      request.body.rewind
      payload = JSON.parse(request.body.read, symbolize_names: true)
      app.settings.game.answer(id, payload,
        lambda {|resp| [400, JSON.pretty_generate(resp)] },
        lambda {|resp| [200, JSON.pretty_generate(resp)] })
    end

  end

end

