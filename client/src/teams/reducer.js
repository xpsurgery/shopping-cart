import { ADD_TEAM_SUCCESS, FETCH_TEAMS_SUCCESS } from './actionCreators'
import { CONFIGURE_SUCCESS } from '../setup/actionCreators'
import { PLAY_SUCCESS, PAUSE_SUCCESS, RESET_SUCCESS } from '../play/actionCreators'

export const palette = [
  'red',
  'cyan',
  'black',
  'green'
]

const teams_in = (hash) => Object.keys(hash).map(key => hash[key])

export default (state=[], action) => {
  switch (action.type) {
    case ADD_TEAM_SUCCESS:
    case CONFIGURE_SUCCESS:
    case FETCH_TEAMS_SUCCESS:
    case PLAY_SUCCESS:
    case PAUSE_SUCCESS:
    case RESET_SUCCESS:
      return teams_in(action.response.teams)

    default:
      return state
  }
}

export const nextAvailableColour = (teams) => {
  return palette[teams.length]
}

