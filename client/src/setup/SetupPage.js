import React from 'react'
import AddTeam from '../teams/AddTeam'
import Teams from '../teams/Teams'
import ChooseLevel from './ChooseLevel'

const Setup = () =>
  <div className='setup-page'>
    <ChooseLevel />
    <Teams />
    <AddTeam />
  </div>

export default Setup

