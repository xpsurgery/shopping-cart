import React from 'react'
import { connect } from 'react-redux'

const Teams = ({ teams }) =>
  <div className='row'>
    <div className='col-md-12'>
      <div className='teams'>
        <h2> Teams </h2>
        <table className='table'>
          <tbody>
            {
              teams.map(team => (
                <tr key={team.id}>
                  <td> {team.name} </td>
                  <td> {team.posUrl} </td>
                  <td> {team.lastResponse} </td>
                  <td> {team.balance} </td>
                </tr>
              ))
            }
          </tbody>
        </table>
      </div>
    </div>
  </div>

const mapStateToProps = (state) => {
  return {
    teams: Object.keys(state.balances).map(teamId => state.balances[teamId])
  }
}

export default connect(mapStateToProps)(Teams)
