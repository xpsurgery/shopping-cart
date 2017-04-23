var Hapi = require('hapi')
var Inert = require('inert')
var uuid = require('uuid')
var config = require('./package.json')
var port = process.env.port || 17171

var server = new Hapi.Server()
var gameState


const initGame = () => {
  gameState = {
    phase: 'adding-teams',
    teams: []
  }
}

initGame()


server.register(Inert, function() {
  server.connection({ port: port })

  server.route({
    method: "GET",
    path: "/{path*}",
    handler:  {
      directory: {
        path: './public',
        listing: false,
        index: true
      }
    }
  })

  server.route({
    method: 'GET',
    path: "/info",
    handler: function(request, reply) {
      reply({version: config.version})
    }
  })

  server.route({
    method: 'POST',
    path: "/game",
    handler: function(request, reply) {
      console.log(Date.now(), 'POST /game')
      gameState.phase = 'adding-teams'
      for (var team of gameState.teams)
        team.balance = 1000000
      reply(gameState)
    }
  })

  server.route({
    method: 'GET',
    path: "/game",
    handler: function(request, reply) {
      console.log(Date.now(), 'GET /game')
      for (var team of gameState.teams)
        team.balance = Math.ceil(Math.random()*1000000)
      reply(gameState)
    }
  })

  server.route({
    method: 'POST',
    path: "/teams",
    handler: function(request, reply) {
      console.log(Date.now(), 'POST /teams', request.payload)
      gameState.teams.push({
        id: request.payload.id,
        name: request.payload.name,
        posUrl: null,
        lastResponse: null,
        balance: 1000000
      })
      reply(gameState)
    }
  })

  server.route({
    method: 'POST',
    path: "/play",
    handler: function(request, reply) {
      console.log(Date.now(), 'POST /play')
      gameState.phase = 'playing'
      reply(gameState)
    }
  })

  server.route({
    method: 'POST',
    path: "/cease",
    handler: function(request, reply) {
      console.log(Date.now(), 'POST /cease')
      gameState.phase = 'analysing'
      reply(gameState)
    }
  })

  server.start((err) => {
    if(err)
      console.log("ERROR starting server:", err)
    console.log("Server listening on port", port)
  })

})
