import React from 'react'
import { connect } from 'react-redux'
import Repeat from './Repeat'
import Teams from '../teams/Teams'
import Balances from '../trends/Balances'
import ControlPanel from './ControlPanel'
import { fetchTeams } from '../teams/actionCreators'

const PlayGame = ({ shouldFetch }) =>
  <div className='playing-page'>
    <Repeat seconds={5} action={fetchTeams} enabled={shouldFetch} />
    <Balances />
    <Teams />
    <ControlPanel />
  </div>

const mapStateToProps = ({ phase }) => ({
  shouldFetch: (phase == 'playing')
})

export default connect(mapStateToProps)(PlayGame)

