const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

const plugins = [
  new HtmlWebpackPlugin({
    template: './index.pug'
  })
]


module.exports = {
  entry: './src/index.js',
  output: {
    path: __dirname + '/static',
    filename: 'bundle.js',
    publicPath: '/'
  },

  module:{
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        exclude: /node_modules/,
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.sass$|\.scss$/,
        loaders: ['style-loader', 'css-loader', 'resolve-url-loader', 'postcss-loader', 'sass-loader?sourceMap']
      },
      {
        test: /\.css$/,
        loaders: ['style-loader', 'css-loader']
      },
      {
        test: /\.tag$/,
        loader: 'tag',
        query: {
          presets: ['es2015']
        },
        exclude: /node_modules/
      },
      {
        test: /\.pug$/,
        loader: 'pug',
        exclude: /node_modules/
      },
      {
        test: /\.woff2?$|\.ttf$|\.eot$|\.svg$|\.png|\.jpe?g|\.gif$/,
        loader: 'file-loader?name=[name].[ext]'
      }
    ]
  },
  plugins
}
