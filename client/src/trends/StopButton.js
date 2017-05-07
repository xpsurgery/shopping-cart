import React from 'react'
import { connect } from 'react-redux'
import { cease } from './actionCreators'

const StartButton = ({dispatch}) =>
  <button className='btn btn-danger' onClick={() => dispatch(cease())}>
    Stop!
  </button>

export default connect()(StartButton)

