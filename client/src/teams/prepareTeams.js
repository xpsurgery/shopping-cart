
const mapStateToProps = ({ teams }) => {
  return {
    teams: teams.sort((a,b) => a.name > b.name ? 1 : -1)
  }
}

export default mapStateToProps

