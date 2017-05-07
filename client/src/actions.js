import { API_CALL } from './app/middleware/api'

export const FETCH_TEAMS_REQUEST = 'FETCH_TEAMS_REQUEST'
export const FETCH_TEAMS_SUCCESS = 'FETCH_TEAMS_SUCCESS'
export const FETCH_TEAMS_FAILURE = 'FETCH_TEAMS_FAILURE'

export const fetchTeams = () => ({
  type: API_CALL,
  endpoint: '/game',
  onRequest: FETCH_TEAMS_REQUEST,
  onSuccess: FETCH_TEAMS_SUCCESS,
  onFailure: FETCH_TEAMS_FAILURE
})

export const ADD_TEAM_REQUEST = 'ADD_TEAM_REQUEST'
export const ADD_TEAM_SUCCESS = 'ADD_TEAM_SUCCESS'
export const ADD_TEAM_FAILURE = 'ADD_TEAM_FAILURE'

export const addTeam = (name) => ({
  type: API_CALL,
  endpoint: '/teams',
  method: 'post',
  body: {
    name: name
  },
  onRequest: ADD_TEAM_REQUEST,
  onSuccess: ADD_TEAM_SUCCESS,
  onFailure: ADD_TEAM_FAILURE
})

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

