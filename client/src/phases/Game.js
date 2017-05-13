import React from 'react'
import { connect } from 'react-redux'
import Header from './Header'
import SetupPage from '../teams/SetupPage'
import PlayingPage from '../trends/PlayingPage'
import { startNewGame } from './actionCreators'

const Game = React.createClass({
  componentDidMount: function() {
    this.props.dispatch(startNewGame())
  },

  render: function() {
    return (
      <div className='container-fluid'>
        <Header />
        <div className='row'>
          <div className='col-md-12'>
            <div className='game'>
              {this.props.phase}
            </div>
          </div>
        </div>
      </div>
    )
  }
})

const phaseComponent = (phase) => {
  switch (phase) {
    case 'setup':
      return <SetupPage />
    case 'playing':
    case 'paused':
      return <PlayingPage />
    default:
      return (<div> Spinner! </div>)
  }
}

const mapStateToProps = ({ phase }) => ({
  phase: phaseComponent(phase)
})

export default connect(mapStateToProps)(Game)

