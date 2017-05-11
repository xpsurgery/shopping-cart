import React from 'react'
import { connect } from 'react-redux'
import { addTeam } from './actionCreators'

const AddTeam = React.createClass({

  keyDown: function(e) {
    if (e.key === 'Enter')
      this.props.addTeam(e.target.value, '#4fe530')
  },

  render: function() {
    return (
      <div>
        <input type='text' onKeyDown={this.keyDown} />
      </div>
    )
  }
})

export default connect(null, { addTeam })(AddTeam)

