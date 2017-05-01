require 'json'

module PlayerApi

  def self.registered(app)

    app.get '/challenge' do
      content_type :json
      host = request.fullpath.gsub(/\/challenge$/, '')
      challenge = app.settings.game.issue
      response_path = "#{host}/answer/#{challenge.id}"
      reply = challenge.challenge.merge({ postResponseTo: response_path })
      [200, JSON.pretty_generate(reply)]
    end

    app.post '/answer/:id' do
      content_type :json
      request.body.rewind
      payload = JSON.parse(request.body.read, symbolize_names: true)
      app.settings.game.answer(params[:id], payload,
        lambda {|resp| [400, JSON.pretty_generate(resp)] },
        lambda {|resp| [200, JSON.pretty_generate(resp)] })
    end

  end

end

