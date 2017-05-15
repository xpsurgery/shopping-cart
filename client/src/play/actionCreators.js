import { API_CALL } from '../app/middleware/api'

export const PLAY_REQUEST = 'PLAY_REQUEST'
export const PLAY_SUCCESS = 'PLAY_SUCCESS'
export const PLAY_FAILURE = 'PLAY_FAILURE'

export const play = () => ({
  type: API_CALL,
  endpoint: '/play',
  method: 'post',
  onRequest: PLAY_REQUEST,
  onSuccess: PLAY_SUCCESS,
  onFailure: PLAY_FAILURE
})

export const PAUSE_REQUEST = 'PAUSE_REQUEST'
export const PAUSE_SUCCESS = 'PAUSE_SUCCESS'
export const PAUSE_FAILURE = 'PAUSE_FAILURE'

export const pause = () => ({
  type: API_CALL,
  endpoint: '/pause',
  method: 'post',
  onRequest: PAUSE_REQUEST,
  onSuccess: PAUSE_SUCCESS,
  onFailure: PAUSE_FAILURE
})

export const RESET_REQUEST = 'RESET_REQUEST'
export const RESET_SUCCESS = 'RESET_SUCCESS'
export const RESET_FAILURE = 'RESET_FAILURE'

export const resetGame = () => ({
  type: API_CALL,
  endpoint: '/reset',
  method: 'post',
  onRequest: RESET_REQUEST,
  onSuccess: RESET_SUCCESS,
  onFailure: RESET_FAILURE
})

