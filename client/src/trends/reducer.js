import {
  ADD_TEAM_SUCCESS,
  FETCH_TEAMS_SUCCESS
} from '../teams/actionCreators'

const initialState = {}

export default (state=initialState, action) => {
  switch (action.type) {
    case ADD_TEAM_SUCCESS:
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

    default:
      return state
  }
}

