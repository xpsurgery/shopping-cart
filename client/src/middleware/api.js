import 'isomorphic-fetch'

const fullUrl = (store, uri) => {
  return "http://localhost:17171" + uri
}

const headers = () => {
  return {
    'Accept':        'application/json',
    'Content-Type':  'application/json'
  }
}

const status = (response) =>
  (response.ok)
    ? Promise.resolve(response)
    : Promise.reject(new Error(response.statusText))

const resolveEndpoint = (endpoint, store) => {
  if (typeof endpoint === 'function')
    endpoint = endpoint(store.getState())
  if (typeof endpoint !== 'string')
    throw new Error('Specify a string endpoint URL.')
  return endpoint
}

const convertToJson = (response) => {
  return (response.status === 204) ? {} : response.text().then((text) => {
    try {
      return JSON.parse(text)
    } catch (e) {
      return { data: text }
    }
  })
}

export const API_CALL = 'API_CALL'

export default store => next => action => {
  if (action.type !== API_CALL)
    return next(action)

  let endpoint = resolveEndpoint(action.endpoint, store)

  if (action.onRequest)
    next({
      type: action.onRequest,
      request: action
    })

  return fetch(fullUrl(store, endpoint), {
    method: action.method || 'get',
    headers: headers(),
    body: JSON.stringify(action.body)
  })
  .then(status)
  .then(convertToJson)
  .then(json => {
    if (action.onSuccess)
      next({
        type: action.onSuccess,
        response: json,
        request: action
      })
  })
  .catch(error => {
    if (action.onFailure)
      next({
        type: action.onFailure,
        error: error.message || 'Something bad happened',
        request: action
      })
  })
}
