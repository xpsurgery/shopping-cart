var jQuery = require('jquery')
window.jQuery = jQuery
window.$ = jQuery
require('bootstrap')           // (for the Bootstrap javascript functionality)

import './index.less'

import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import configureStore from './store'
import Game from './components/Game'

const store = configureStore()

render(
  <Provider store={store}>
    <Game />
  </Provider>,
  document.getElementById('root')
)
