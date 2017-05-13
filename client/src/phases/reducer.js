import { START_NEW_GAME_SUCCESS } from './actionCreators'
import { CONFIGURE_SUCCESS, PLAY_SUCCESS, CEASE_SUCCESS } from '../trends/actionCreators'

export default (state='fetching', action) => {
  switch (action.type) {
    case START_NEW_GAME_SUCCESS:
    case CONFIGURE_SUCCESS:
    case PLAY_SUCCESS:
    case CEASE_SUCCESS:
      return action.response.phase

    default:
      return state
  }
}

