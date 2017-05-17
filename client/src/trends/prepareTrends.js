import { dataSeries } from './reducer'

export default ({ trends }) => ({
  trends: dataSeries(trends)
})

