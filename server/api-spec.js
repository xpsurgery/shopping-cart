require('es6-promise').polyfill();
require('isomorphic-fetch')
var uuid = require('uuid')
var expect = require('chai').expect

const toJson = (response) => {
  expect(response.status).to.equal(200)
  return response.text().then(text => JSON.parse(text))
}

const url = (path) => `http://127.0.0.1:17171${path}`

describe('server API', () => {
  it('returns info', (done) => {
    fetch(url('/info'))
    .then(response => {
      expect(response.status).to.equal(200)
      done()
    })
    .catch(error => {
      done(error)
    })
  })

  describe('new game', () => {
    it('has no teams', done => {
      fetch(url('/game'), { method: 'post' })
        .then(toJson)
        .then(json => {
          expect(json).to.deep.equal({phase: 'adding-teams', teams: []})
          done()
        })
        .catch(error => {
          done(error)
        })
    })
  })

  describe('add team', () => {
    it('has one team', done => {
      var id = uuid.v1()
      fetch(url('/game'), { method: 'post' })
      fetch(url('/teams'), {
        method: 'post',
        body: JSON.stringify({ id: id, name: 'All stars' })
      })
      .then(toJson)
      .then(json => {
        expect(json).to.deep.equal({
          phase: 'adding-teams',
          teams: [{
            id: id,
            name: 'All stars',
            posUrl: null,
            lastResponse: null,
            balance: 1000000
          }]
        })
        fetch(url('/game'))
        .then(toJson)
        .then(json => {
          expect(json.teams[0].name).to.equal('All stars')
          done()
        })
      })
      .catch(error => {
        done(error)
      })
    })
  })
})
