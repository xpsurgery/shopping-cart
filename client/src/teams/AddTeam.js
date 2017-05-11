import React from 'react'
import { connect } from 'react-redux'
import { addTeam } from './actionCreators'
import mapStateToProps from './prepareAddTeam'

const AddTeam = React.createClass({

  keyDown: function(e) {
    if (e.key === 'Enter')
      this.props.addTeam(e.target.value, this.props.colour)
  },

  render: function() {
    return (
      <div>
        <input type='text' onKeyDown={this.keyDown} />
      </div>
    )
  }
})

export default connect(mapStateToProps, { addTeam })(AddTeam)

