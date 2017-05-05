import React from 'react'
import { connect } from 'react-redux'
import Header from './Header'
import AddTeams from './AddTeams'
import PlayGame from './PlayGame'
import Analyse from './Analyse'
import { startNewGame } from '../actions'

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

const phaseDisplays = {
  'setup': <AddTeams />,
  'playing':      <PlayGame />,
  'analysing':    <Analyse />
}

const mapStateToProps = (state) => ({
  phase: phaseDisplays[state.phase]
})

export default connect(mapStateToProps)(Game)
