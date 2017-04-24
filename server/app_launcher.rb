require 'sinatra/base'
require 'logger'
require_relative './api'

class ShoppingCartGame < Sinatra::Base

  configure do
    disable :show_exceptions
    enable :logging
  end

  before do
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, Authorization, Origin'
  end

  options '*' do
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, Authorization, Origin'
    200
  end

  get '/index.html' do
    [
      '<!DOCTYPE html>',
      '<html lang="en">',
        '<head>',
          '<meta charset="UTF-8">',
          '<title> Shopping cart game </title>',
        '</head>',
        '<body>',
          '<div id="root"></div>',
          '<script src="/bundle.js"></script>',
        '</body>',
      '</html>'
    ]
  end

  register Api

  not_found do
    content_type :json
    [404, {error: 'not found'}.to_json]
  end

end
