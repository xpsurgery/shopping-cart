import React from 'react'
import { connect } from 'react-redux'
import { cease } from '../actions'

const StartButton = ({dispatch}) =>
  <button className='btn btn-danger' onClick={() => dispatch(cease())}>
    Stop!
  </button>

export default connect()(StartButton)
