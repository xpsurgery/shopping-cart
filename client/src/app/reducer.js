import { combineReducers } from 'redux'
import phase from '../game/reducer'
import teams from '../teams/reducer'
import balances from '../trends/reducer'

export default combineReducers({
  phase,
  teams,
  balances
})

