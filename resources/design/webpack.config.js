const path = require("path");

module.exports = {
  mode: "production",
  entry: "./js/index.js",
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/i,
        include: path.resolve(__dirname, 'js'),
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      },
      {
        test: /\.scss$/i,
        include: path.resolve(__dirname, 'dist'),
        use: ['sass-loader', 'style-loader', 'css-loader', 'postcss-loader'],
      }
    ]
  },
  devServer: {
    static: 'dist',
    watchContentBase: true,
  }
}
