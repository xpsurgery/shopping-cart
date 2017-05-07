import { combineReducers } from 'redux'
import balances from '../trends/reducer'
import phase from '../phases/reducer'

export default combineReducers({
  phase,
  balances
})

