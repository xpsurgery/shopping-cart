import { expect } from 'chai'
import { reductio } from '../app/specHelper'
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
      expect(reductio(reducer, [addTeamSuccess])).to.deep.eq([
        { name: 'qwerty', data: []},
        { name: 'asdf', data: []}
      ])
    })

  })

})

