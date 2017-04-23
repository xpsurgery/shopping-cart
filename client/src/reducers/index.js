import { combineReducers } from 'redux'
import balances from './balances'
import phase from './phase'

export default combineReducers({
  balances,
  phase
})
