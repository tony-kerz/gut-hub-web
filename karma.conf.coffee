module.exports = (config) ->
  config.set
    basePath: 'build'
    browsers: ['Chrome']
    frameworks: ['jasmine']
    files: [
      'vendor/jquery/**/*.js'
      'vendor/angular/**/*.js'
      'vendor/bootstrap-sass-official/**/tooltip.js'
      'vendor/**/*.js'
      '**/*.js'
    ]
    reporters: ['spec']
