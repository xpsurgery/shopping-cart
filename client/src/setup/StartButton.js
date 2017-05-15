import React from 'react'
import { connect } from 'react-redux'
import { configure } from './actionCreators'

const StartButton = ({ level, config, configure }) =>
  <button className='btn btn-primary' onClick={() => configure(config)}>
    {level}
  </button>

export default connect(undefined, { configure })(StartButton)

