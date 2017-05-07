import React from 'react'
import { connect } from 'react-redux'
import { startNewGame } from './actionCreators'

const RestartButton = ({dispatch}) =>
  <button className='btn btn-primary' onClick={() => dispatch(startNewGame())}>
    Start a new game
  </button>

export default connect()(RestartButton)

