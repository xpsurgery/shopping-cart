import { ADD_TEAM_SUCCESS } from './actionCreators'

let initialState = [
  { id: 2, name: 'gym', colour: "#49078d", balance: 105463 },
  { id: 1, name: 'fred', colour: "#23fe4d", balance: 105463 },
  { id: 3, name: 'suup', colour: "#1fffe4", balance: 105463 }
]

export default (state=initialState, action) => {
  switch (action.type) {
    case ADD_TEAM_SUCCESS:
      return Object.keys(action.response.teams).map(key => action.response.teams[key])

    default:
      return state
  }
}

