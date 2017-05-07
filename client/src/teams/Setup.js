import React from 'react'
import StartButton from '../trends/StartButton'
import AddTeam from './AddTeam'
import Teams from './Teams'

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

