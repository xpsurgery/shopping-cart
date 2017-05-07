import React from 'react'
import { connect } from 'react-redux'

const Teams = ({ teams }) =>
  <div className='teams'>
    <table className='table'>
      <tbody>
        {
          teams.map(team => (
            <tr key={team.id}>
              <td> {team.name} </td>
              <td> {team.colour} </td>
              <td> {team.balance} </td>
            </tr>
          ))
        }
      </tbody>
    </table>
  </div>

const mapStateToProps = (state) => {
  return {
    teams: Object.keys(state.balances).map(teamId => state.balances[teamId])
  }
}

export default connect(mapStateToProps)(Teams)
