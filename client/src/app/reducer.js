import { combineReducers } from 'redux'
import balances from '../reducers/balances'
import phase from '../phases/reducer'

export default combineReducers({
  balances,
  phase
})
