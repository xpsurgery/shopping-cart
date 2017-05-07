import React from 'react'
import { connect } from 'react-redux'
import { play } from './actionCreators'

const StartButton = ({dispatch}) =>
  <button className='btn btn-primary' onClick={() => dispatch(play())}>
    Start!
  </button>

export default connect()(StartButton)

