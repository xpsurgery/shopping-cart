import React from 'react'
import StartButton from './StartButton'
import AddTeam from '../teams/AddTeam'
import Teams from '../teams/Teams'

const Setup = () =>
  <div>
    <div className='row'>
      <div className='col-md-12'>
        <Teams />
      </div>
    </div>
    <div className='row'>
      <div className='col-md-12'>
        <AddTeam />
      </div>
    </div>
    <div className='row'>
      <div className='col-md-12'>
        <p>
          When all teams have been added <StartButton />
        </p>
      </div>
    </div>
  </div>

export default Setup

