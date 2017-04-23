var path = require('path')

module.exports = {

  entry: [
    'babel-polyfill',
    './src'
  ],

  output: {
    path: path.join(__dirname, '../server/public'),
    filename: 'bundle.js'
  },

  resolve: {
    extensions: ['', '.js', '.jsx']
  },

  resolveLoader: {
    root: path.join(__dirname, 'node_modules')
  },

  module: {

    preLoaders: [
      { test: /\.js$/, loader: "eslint-loader", include: __dirname }
    ],

    loaders: [
      { test: /\.js$/, loader: 'babel-loader', exclude: [path.resolve(__dirname, "node_modules")] },
      { test: /\.less$/, loader: 'style!css!less' },
      { test: /\.(ttf|eot|svg|woff(2)?)(\?[a-z0-9]+)?$/, loader: "file" }
    ]
  },

  eslint: {
    failOnError: true
  }
}
