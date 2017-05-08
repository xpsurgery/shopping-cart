import { expect } from 'chai'
import { ADD_TEAM_SUCCESS } from './actionCreators'
import reducer from './reducer'

describe('teams', () => {

  describe('when a team has been added', () => {

    it('stores the teams', () => {
      let teams = [
        { id: 2, name: 'qwerty', colour: "#49078d", balance: 105463 },
        { id: 3, name: 'asdf', colour: "#1fffe4", balance: 105463 }
      ]
      let action = {
        type: ADD_TEAM_SUCCESS,
        response: {
          teams: {
            "qwerty": teams[0],
            "asdf": teams[1]
          }
        }
      }
      expect(reducer({}, action)).to.deep.eq(teams)
    })

  })

})

