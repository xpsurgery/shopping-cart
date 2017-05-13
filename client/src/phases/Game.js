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

const mapStateToProps = ({ phase }) => ({
  phase: (phase === 'setup' ? <SetupPage /> : <PlayingPage />)
})

export default connect(mapStateToProps)(Game)

