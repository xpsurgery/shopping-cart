import React from 'react'
import { connect } from 'react-redux'
import TrendsChart from './TrendsChart'
import mapStateToProps from './prepareTrends'

const Trends = ({ trends }) =>
  <div className='trends'>
    <TrendsChart dataSeries={trends} />
  </div>

export default connect(mapStateToProps)(Trends)
