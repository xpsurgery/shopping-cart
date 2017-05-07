import { API_CALL } from '../app/middleware/api'

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

