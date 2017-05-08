import { expect } from 'chai'
import mapStateToProps from './prepareTeams'

describe('prepareTeams', () => {

  it('sorts them alphabetically by name', () => {
    let storeTeams = [
      { id: 2, name: 'gym', colour: "#49078d", balance: 105463 },
      { id: 1, name: 'fred', colour: "#23fe4d", balance: 105463 },
      { id: 3, name: 'suup', colour: "#1fffe4", balance: 105463 }
    ]
    expect(mapStateToProps({ teams: storeTeams }).teams).to.deep.eq([
      { id: 1, name: 'fred', colour: "#23fe4d", balance: 105463 },
      { id: 2, name: 'gym', colour: "#49078d", balance: 105463 },
      { id: 3, name: 'suup', colour: "#1fffe4", balance: 105463 }
    ])
  })

})

