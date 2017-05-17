import { expect } from 'chai'
import { reductio } from '../app/specHelper'
import { ADD_TEAM_SUCCESS, FETCH_TEAMS_SUCCESS } from '../teams/actionCreators'
import reducer, { dataSeries } from './reducer'

const addTeamSuccess = {
  type: ADD_TEAM_SUCCESS,
  response: {
    teams: {
      "qwerty": { name: 'qwerty', cashBalance: 0 },
      "asdf": { name: 'asdf', cashBalance: 0 }
    }
  }
}

describe('trends', () => {

  describe('when a team has been added', () => {

    it('stores the teams', () => {
      expect(reductio(reducer, [addTeamSuccess])).to.deep.eq(addTeamSuccess.response.teams)
    })

  })

  describe('when scores are fetched', () => {

    it('stores the trends', () => {
      let actions = [
        addTeamSuccess, {
          type: FETCH_TEAMS_SUCCESS,
          response: {
            teams: {
              "qwerty": { name: 'qwerty', cashBalance: 1 },
              "asdf": { name: 'asdf', cashBalance: 4 }
            }
          }
        }, {
          type: FETCH_TEAMS_SUCCESS,
          response: {
            teams: {
              "qwerty": { name: 'qwerty', cashBalance: 2 },
              "asdf": { name: 'asdf', cashBalance: 5 }
            }
          }
        }, {
          type: FETCH_TEAMS_SUCCESS,
          response: {
            teams: {
              "qwerty": { name: 'qwerty', cashBalance: 3 },
              "asdf": { name: 'asdf', cashBalance: 6 }
            }
          }
        }
      ]
      let state = reductio(reducer, actions)
      expect(dataSeries(state)).to.deep.eq([
        { name: 'qwerty', data: [1, 2, 3]},
        { name: 'asdf', data: [4, 5, 6]}
      ])
    })

  })

})

