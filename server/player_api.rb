require 'json'
require 'hashie/mash'

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
      begin
        payload = Hashie::Mash.new(JSON.parse(request.body.read, symbolize_names: true))
        app.settings.game.answer(params[:id], payload,
          -> resp { [400, JSON.pretty_generate(resp)] },
          -> errors { [200, JSON.pretty_generate(errors)] })
      rescue JSON::ParserError
        [400, JSON.pretty_generate({
          error: 'Your response must be valid JSON'
        })]
      end
    end

  end

end

