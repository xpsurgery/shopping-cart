import React from 'react'

export default ({ name, colour, cash_balance }) =>
  <div className='team-summary' style={{'border-color': colour}}>
    <div className='team-colour' style={{ backgroundColor:colour }}> &nbsp; </div>
    <div className='team-name'> {name} </div>
    <div className='team-balance'> {cash_balance} </div>
  </div>

