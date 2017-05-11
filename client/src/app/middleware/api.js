import 'isomorphic-fetch'

//- - - Action creators - - - - - - - - - - - - - - - - - - - - - - - - -

export const API_CALL = 'api/API_CALL'

const apiRequest = action => ({
  type: action.onRequest,
  request: action
})

const apiSuccess = (action, response) => ({
  type: action.onSuccess,
  response: response,
  request: action
})

const apiFailure = (action, error) => ({
  type: action.onFailure,
  error: error,
  request: action
})

const headers = () => {
  return {
    'Accept':        'application/json',
    'Content-Type':  'application/json'
  }
}

const status = (response) =>
  response.ok
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

export default store => next => action => {
  if (action.type !== API_CALL)
    return next(action)

  const resolvedAction = {
    ...action,
    actualEndpoint: `http://localhost:17171${resolveEndpoint(action.endpoint, store)}`          // TODO: find a better place for this
  }

  action.onRequest && next(apiRequest(resolvedAction))

  return fetch(resolvedAction.actualEndpoint, {
    method: resolvedAction.method || 'get',
    headers: headers(store),
    body:    JSON.stringify(resolvedAction.body)
  })
  .then(status)
  .then(convertToJson)
  .then(json => action.onSuccess && next(apiSuccess(resolvedAction, json)) )
  .catch(error => {
    action.onFailure && next(apiFailure(resolvedAction, error.message || 'Something bad happened'))
  })
}

//- - - Action creators - - - - - - - - - - - - - - - - - - - - - - - - -

const SUCCEED_NEXT_API_CALL = 'api/SUCCEED_NEXT_API_CALL'
const FAIL_NEXT_API_CALL = 'api/FAIL_NEXT_API_CALL'

export const succeedNextWith = response => ({
  type: SUCCEED_NEXT_API_CALL,
  nextBody: response
})

export const failNextWith = response => ({
  type: FAIL_NEXT_API_CALL,
  nextBody: response
})

//- - - Test harness - - - - - - - - - - - - - - - - - - - - - - - - - -

let nextAction, nextFailure

const dispatchRequestAndResult = (store, next, action) => {
  const resolvedAction = {
    ...action,
    actualEndpoint: resolveEndpoint(action.endpoint, store)
  }

  let result

  if (action.onRequest)
    result = next(apiRequest(resolvedAction))

  if (nextAction) {
    if (action.onSuccess)
      result = next(apiSuccess(resolvedAction, nextAction.nextBody))
    nextAction = null
  } else if (nextFailure) {
    if (action.onFailure)
      result = next(apiFailure(resolvedAction, nextFailure.nextBody))
    nextFailure = null
  }
  return result
}

export const testHarness = store => next => action => {
  switch (action.type) {
    case SUCCEED_NEXT_API_CALL:
      nextAction = action
      return null

    case FAIL_NEXT_API_CALL:
      nextFailure = action
      return null

    case API_CALL:
      return dispatchRequestAndResult(store, next, action)

    default:
      return next(action)
  }

}
