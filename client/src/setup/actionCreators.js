import { API_CALL } from '../app/middleware/api'

export const CONFIGURE_REQUEST = 'CONFIGURE_REQUEST'
export const CONFIGURE_SUCCESS = 'CONFIGURE_SUCCESS'
export const CONFIGURE_FAILURE = 'CONFIGURE_FAILURE'

export const configure = () => ({
  type: API_CALL,
  endpoint: '/configure',
  method: 'post',
  body: {},
  onRequest: CONFIGURE_REQUEST,
  onSuccess: CONFIGURE_SUCCESS,
  onFailure: CONFIGURE_FAILURE
})

