
export default ({ trends }) => {
  return {
    trends: Object.keys(trends).map(teamId => ({
      name: trends[teamId].name,
      data: trends[teamId].history
    }))
  }
}
