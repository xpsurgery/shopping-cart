import React from 'react'
import StartButton from './StartButton'

const easyConfig = {
  initialBalance: 1000000
}

const hardConfig = {
  initialBalance: 100000
}

const impossibleConfig = {
  initialBalance: 50000,
  payroll: {
    interval_secs: 15,
    wage_bill: 1000
  }
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

