import React from 'react'
import { connect } from 'react-redux'
import { addTeam } from '../actions'

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
    this.props.dispatch(addTeam(this.state.value))
    this.setState({value: ''})
  },

  render: function() {
    return (
      <tr>
        <td> <input type='text' value={this.state.value} onChange={this.char} /> </td>
        <td> <button onClick={this.add}> Add </button> </td>
      </tr>
    )
  }
})

export default connect()(AddTeam)
