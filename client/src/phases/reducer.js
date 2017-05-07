import { START_NEW_GAME_SUCCESS, PLAY_SUCCESS, CEASE_SUCCESS } from '../actions'

export default (state=null, action) => {
  switch (action.type) {
    case START_NEW_GAME_SUCCESS:
    case PLAY_SUCCESS:
    case CEASE_SUCCESS:
      return action.response.phase

    default:
      return state
  }
}
