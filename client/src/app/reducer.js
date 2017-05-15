import { combineReducers } from 'redux'
import phase from '../game/reducer'
import teams from '../teams/reducer'
import trends from '../trends/reducer'

export default combineReducers({
  phase,
  teams,
  trends
})

