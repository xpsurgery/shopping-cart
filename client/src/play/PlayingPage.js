import React from 'react'
import { connect } from 'react-redux'
import Repeat from './Repeat'
import Teams from '../teams/Teams'
import Balances from '../trends/Balances'
import ControlPanel from './ControlPanel'
import { fetchTeams } from '../teams/actionCreators'

const PlayGame = React.createClass({
  render: function() {
    return (
      <div className='playing-page'>
        <Repeat seconds={5} action={fetchTeams} />
        <Balances />
        <Teams />
        <ControlPanel />
      </div>
    )
  }
})

export default connect()(PlayGame)

