import React from 'react'
import { connect } from 'react-redux'
import Teams from './Teams'
import Balances from './Balances'
import RestartButton from './RestartButton'

const Analyse = React.createClass({
  render: function() {
    return (
      <div>
        <Teams />
        <Balances />
        <RestartButton />
      </div>
    )
  }
})

export default connect()(Analyse)
