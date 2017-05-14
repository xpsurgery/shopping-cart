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

export const CEASE_REQUEST = 'CEASE_REQUEST'
export const CEASE_SUCCESS = 'CEASE_SUCCESS'
export const CEASE_FAILURE = 'CEASE_FAILURE'

export const cease = () => ({
  type: API_CALL,
  endpoint: '/cease',
  method: 'post',
  onRequest: CEASE_REQUEST,
  onSuccess: CEASE_SUCCESS,
  onFailure: CEASE_FAILURE
})

