import { ADD_TEAM_SUCCESS, FETCH_TEAMS_SUCCESS } from '../teams/actionCreators'
import { RESET_SUCCESS } from '../play/actionCreators'

const initialState = {}

export default (state=initialState, action) => {
  switch (action.type) {

    case ADD_TEAM_SUCCESS:
      return action.response.teams

    case FETCH_TEAMS_SUCCESS:
      var newstate = {...state}
      for (let teamName in action.response.teams) {
        let team = {
          name: newstate[teamName].name,
          data: newstate[teamName].data || []
        }
        team.data = team.data.concat([action.response.teams[teamName].cashBalance])
        newstate[teamName] = team
      }
      return newstate

    case RESET_SUCCESS:
      return initialState

    default:
      return state
  }
}

export const dataSeries = (state) => Object.keys(state).map(key => state[key])

