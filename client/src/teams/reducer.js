import { ADD_TEAM_SUCCESS } from './actionCreators'

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
      return teams_in(action.response.teams)

    default:
      return state
  }
}

export const nextAvailableColour = (teams) => {
  return palette[teams.length]
}

