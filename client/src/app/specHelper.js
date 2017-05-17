import deepFreeze from 'deep-freeze'
//import configureStore from '../store/configureStore'

//export const reduce = (actions) => {
  //const store = configureStore()
  //actions.forEach(action => store.dispatch(action))
  //return store.getState()
//}

export const reductio = (reducer, actions) => {
  var state = reducer(undefined, {type: 'NO_SUCH_ACTION'})
  for (var action of actions) {
    deepFreeze(state)
    state = reducer(state, action)
  }
  return state
}
