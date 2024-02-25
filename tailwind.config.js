module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      // MEMO: 頻繁に利用するカラーを設定
      colors: {
        'dark-green': '#4B5049',
        'light-green': '#669988'
      }
    }
  }
}
