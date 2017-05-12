import { expect } from 'chai'
import { ADD_TEAM_SUCCESS } from './actionCreators'
import reducer, { nextAvailableColour, palette } from './reducer'

const teams = [
  { id: 2, name: 'qwerty', colour: "#49078d", balance: 105463 },
  { id: 3, name: 'asdf', colour: "#1fffe4", balance: 105463 }
]

const addTeamSuccess = {
  type: ADD_TEAM_SUCCESS,
  response: {
    teams: {
      "qwerty": teams[0],
      "asdf": teams[1]
    }
  }
}

describe('teams', () => {

  describe('when a team has been added', () => {

    it('stores the teams', () => {
      expect(reducer({}, addTeamSuccess)).to.deep.eq(teams)
    })

  })

})

describe('nextAvailableColour', () => {

  describe('when there is one team already', () => {

    it('returns the second colour', () => {
      const state = reducer(undefined, addTeamSuccess)
      expect(nextAvailableColour(state)).to.eq(palette[2])
    })

  })

})

