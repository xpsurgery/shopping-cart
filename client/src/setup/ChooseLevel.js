import React from 'react'
import StartButton from './StartButton'

const easyConfig = {
  initial_balance: 1000000
}

const hardConfig = {
  initial_balance: 100000
}

const impossibleConfig = {
  initial_balance: 50000
}

const ChooseLevel = () =>
  <div className='choose-level'>
    <p>
      Choose your game&apos;s difficulty:
    </p>
    <StartButton level='Easy' config={easyConfig} />
    <StartButton level='Hard' config={hardConfig} />
    <StartButton level='Impossible' config={impossibleConfig} />
  </div>

export default ChooseLevel

