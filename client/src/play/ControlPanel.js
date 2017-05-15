import React from 'react'
import { connect } from 'react-redux'
import { cease } from './actionCreators'

const ControlPanel = ({dispatch}) =>
  <div className='control-panel'>
    <button className='btn btn-danger' onClick={() => dispatch(cease())}>
      Play
    </button>
    <button className='btn btn-danger' onClick={() => dispatch(cease())}>
      Pause
    </button>
    <button className='btn btn-danger' onClick={() => dispatch(cease())}>
      Restart
    </button>
  </div>

export default connect()(ControlPanel)

