import { expect } from 'chai'
import { ADD_TEAM_SUCCESS } from '../teams/actionCreators'
import reducer from './reducer'

const addTeamSuccess = {
  type: ADD_TEAM_SUCCESS,
  response: {
    teams: {
      "qwerty": {},
      "asdf": {}
    }
  }
}

describe('trends', () => {

  describe('when a team has been added', () => {

    it('stores the teams', () => {
      expect(reducer({}, addTeamSuccess)).to.deep.eq([
        { name: 'qwerty', data: []},
        { name: 'asdf', data: []}
      ])
    })

  })

})

