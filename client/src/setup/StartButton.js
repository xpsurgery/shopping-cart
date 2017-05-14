import React from 'react'
import { connect } from 'react-redux'
import { configure } from './actionCreators'

const StartButton = ({ configure }) =>
  <button className='btn btn-primary' onClick={() => configure()}>
    Start!
  </button>

export default connect(undefined, { configure })(StartButton)

