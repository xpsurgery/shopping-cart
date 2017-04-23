import React from 'react'
import { connect } from 'react-redux'
import StartButton from './StartButton'
import AddTeam from './AddTeam'

const AddTeams = ({ teams }) =>
  <div className='row'>
    <div className='col-md-12'>
      <div className='teams'>
        <h2> Add teams </h2>
        <table className='table'>
          <thead>
            <tr>
              <th> Name </th>
              <th> Balance </th>
            </tr>
          </thead>
          <tbody>
            {
              teams.map(team => (
                <tr key={team.id}>
                  <td> {team.name} </td>
                  <td> {team.balance} </td>
                </tr>
              ))
            }
            <AddTeam />
          </tbody>
        </table>
        <p>
          When all teams have been added <StartButton />
        </p>
      </div>
    </div>
  </div>

const mapStateToProps = (state) => {
  return {
    teams: Object.keys(state.balances).map(teamId => state.balances[teamId])
  }
}

export default connect(mapStateToProps)(AddTeams)
