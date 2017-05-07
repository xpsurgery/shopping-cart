import React from 'react'
import { connect } from 'react-redux'
import mapStateToProps from './prepareTeams'

const Teams = ({ teams }) =>
  <div className='teams'>
    <table className='table'>
      <tbody>
        {
          teams.map(team => (
            <tr key={team.id}>
              <td> {team.name} </td>
              <td style={{backgroundColor:team.colour}}> &nbsp; </td>
              <td> {team.balance} </td>
            </tr>
          ))
        }
      </tbody>
    </table>
  </div>

export default connect(mapStateToProps)(Teams)

