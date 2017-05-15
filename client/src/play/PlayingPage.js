import React from 'react'
import { connect } from 'react-redux'
import Repeat from './Repeat'
import Teams from '../teams/Teams'
import Balances from '../trends/Balances'
import StopButton from './StopButton'
import { fetchTeams } from '../teams/actionCreators'

const PlayGame = React.createClass({
  render: function() {
    return (
      <div>
        <Repeat seconds={2} action={fetchTeams} />
        <Teams />
        <Balances />
        <StopButton />
      </div>
    )
  }
})

export default connect()(PlayGame)

