import React from 'react'
import { connect } from 'react-redux'
import TeamSummary from './TeamSummary'
import mapStateToProps from './prepareTeams'

const Teams = ({ teams }) =>
  <div className='teams'>
    {
      teams.map(team => (
        <TeamSummary key={team.id} {...team} />
      ))
    }
  </div>

export default connect(mapStateToProps)(Teams)

