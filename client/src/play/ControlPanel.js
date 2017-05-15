import React from 'react'
import { connect } from 'react-redux'
import { play, pause, resetGame } from './actionCreators'

const ControlPanel = ({dispatch}) =>
  <div className='control-panel'>
    <button className='btn btn-danger' onClick={() => dispatch(play())}>
      Play
    </button>
    <button className='btn btn-danger' onClick={() => dispatch(pause())}>
      Pause
    </button>
    <button className='btn btn-danger' onClick={() => dispatch(resetGame())}>
      Restart
    </button>
  </div>

export default connect()(ControlPanel)

