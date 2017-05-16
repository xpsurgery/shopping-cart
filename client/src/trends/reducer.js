import { ADD_TEAM_SUCCESS, FETCH_TEAMS_SUCCESS } from '../teams/actionCreators'
import { RESET_SUCCESS } from '../play/actionCreators'

const initialState = {}

export default (state=initialState, action) => {
  switch (action.type) {

    case ADD_TEAM_SUCCESS:
      return Object.keys(action.response.teams).map(name => ({
        name: name,
        data: []
      }))

    case FETCH_TEAMS_SUCCESS:
      var newstate = {...state}
      for (let team in action.response.teams) {
        if (!newstate[team.id])
          newstate[team.id] = {
            ...team,
            history: []
          }
        newstate[team.id].history.push(team.balance)
        newstate[team.id].balance = team.balance
      }
      return newstate

    case RESET_SUCCESS:
      return initialState

    default:
      return state
  }
}

