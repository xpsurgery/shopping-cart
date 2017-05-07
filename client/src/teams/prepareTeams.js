
const mapStateToProps = () => {
  let teams = [
    { id: 2, name: 'gym', colour: "#49078d", balance: 105463 },
    { id: 1, name: 'fred', colour: "#23fe4d", balance: 105463 },
    { id: 3, name: 'suup', colour: "#1fffe4", balance: 105463 }
  ]
  return {
    teams: teams.sort((a,b) => a.name > b.name ? 1 : -1)
  }
}

export default mapStateToProps

