import React from 'react'
import { connect } from 'react-redux'
import Repeat from './Repeat'
import Teams from '../teams/Teams'
import Trends from '../trends/Trends'
import ControlPanel from './ControlPanel'
import { fetchTeams } from '../teams/actionCreators'

const PlayGame = ({ shouldFetch }) =>
  <div className='playing-page'>
    <Repeat seconds={5} action={fetchTeams} enabled={shouldFetch} />
    <Trends />
    <Teams />
    <ControlPanel />
  </div>

const mapStateToProps = ({ phase }) => ({
  shouldFetch: (phase == 'playing')
})

export default connect(mapStateToProps)(PlayGame)

