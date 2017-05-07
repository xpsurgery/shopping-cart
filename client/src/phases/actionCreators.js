import { API_CALL } from '../app/middleware/api'

export const START_NEW_GAME_REQUEST = 'START_NEW_GAME_REQUEST'
export const START_NEW_GAME_SUCCESS = 'START_NEW_GAME_SUCCESS'
export const START_NEW_GAME_FAILURE = 'START_NEW_GAME_FAILURE'

export const startNewGame = () => ({
  type: API_CALL,
  endpoint: '/setup',
  method: 'post',
  onRequest: START_NEW_GAME_REQUEST,
  onSuccess: START_NEW_GAME_SUCCESS,
  onFailure: START_NEW_GAME_FAILURE
})

