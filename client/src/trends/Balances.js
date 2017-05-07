import React from 'react'
import { connect } from 'react-redux'
import BalancesHistoryChart from './BalancesHistoryChart'

const Balances = ({ balances }) =>
  <div className='row'>
    <div className='col-md-12'>
      <div className='teams'>
        <h2> Balances </h2>
        <BalancesHistoryChart dataSeries={balances} />
      </div>
    </div>
  </div>

const mapStateToProps = (state) => {
  return {
    balances: Object.keys(state.balances).map(teamId => ({
      name: state.balances[teamId].name,
      data: state.balances[teamId].history
    }))
  }
}

export default connect(mapStateToProps)(Balances)
