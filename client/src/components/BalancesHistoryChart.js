import React from 'react'
import 'highcharts'
import ReactHighcharts from 'react-highcharts'

var lineChart = {
  chart: {
    zoomType: 'x'
  },
  title: { text: 'Team bank balances' },
  xAxis: {
    labels: { enabled: false }
  },
  yAxis: {
    min: 0,
    title: { text: 'Euros' }
  },
  plotOptions: {},
  legend: {
    layout: 'vertical',
    align: 'left',
    x: 120,
    verticalAlign: 'top',
    y: 100,
    floating: true,
    backgroundColor: '#FFFFFF'
  }
}

const BalancesHistoryChart = ({ dataSeries }) => {
  return (
    <div className='inset form-submission-history-chart'>
      <ReactHighcharts config={{
        ...lineChart,
        series: dataSeries
      }} isPureConfig={true} />
    </div>
  )
}

BalancesHistoryChart.propTypes = {
  dataSeries: React.PropTypes.array
}

export default BalancesHistoryChart
