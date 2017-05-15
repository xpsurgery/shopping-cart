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

const TrendsChart = ({ dataSeries }) => {
  return (
    <div className='trends-chart'>
      <ReactHighcharts config={{
        ...lineChart,
        series: dataSeries
      }} isPureConfig={true} />
    </div>
  )
}

TrendsChart.propTypes = {
  dataSeries: React.PropTypes.array
}

export default TrendsChart

