import React from 'react'
import { connect } from 'react-redux'
import { addTeam } from './actionCreators'

const AddTeam = React.createClass({
  getInitialState: function() {
    return {
      value: ''
    }
  },

  char: function(e) {
    this.setState({value: e.target.value})
  },

  add: function() {
    this.props.addTeam(this.state.value)
    this.setState({value: ''})
  },

  render: function() {
    return (
      <div>
        <input type='text' value={this.state.value} onChange={this.char} />
        <button onClick={this.add}> Add </button>
      </div>
    )
  }
})

export default connect(null, { addTeam })(AddTeam)

