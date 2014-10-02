argv = require('minimist')(process.argv.slice 2)
gulp = require 'gulp'
plug = require('gulp-load-plugins')()
bower = require 'main-bower-files'
run = require 'run-sequence'
del = require 'del'
lazy = require 'lazypipe'

optJsStream = lazy()
  .pipe plug.concat, 'all.min.js'
  .pipe plug.uglify

optCssStream = lazy()
  .pipe plug.concat, 'all.min.css'
  .pipe plug.minifyCss

optFontStream = lazy()
  .pipe plug.flatten
  .pipe gulp.dest, 'build/fonts'

gulp.task 'coffee', ->
  gulp.src 'src/**/*.coffee'
  .pipe plug.coffee().on 'error', plug.util.log
  .pipe plug.if argv.optimize, plug.ngAnnotate()
  .pipe plug.if argv.optimize, optJsStream()
  .pipe gulp.dest 'build'

gulp.task 'less', ->
  gulp.src 'src/less/main.less'
  .pipe plug.less()
  .pipe plug.if argv.optimize, plug.rev()
  .pipe gulp.dest 'build/assets'

gulp.task 'bower-js', ->
  gulp.src bower(filter: new RegExp '^.*\.js$'), base: 'bower_components'
  .pipe plug.if argv.optimize, optJsStream()
  .pipe gulp.dest 'build/vendor'

gulp.task 'bower-css', ->
  gulp.src bower(filter: new RegExp '^.*\.css$'), base: 'bower_components'
  .pipe plug.if argv.optimize, optCssStream()
  .pipe gulp.dest 'build/vendor'

gulp.task 'bower-font', ->
  gulp.src bower(filter: new RegExp '^.*\.(eot|svg|ttf|woff)$'), base: 'bower_components'
  # when optimizing need to put files directly in 'build/fonts'
  #.pipe plug.if argv.optimize, optCssStream()
  .pipe gulp.dest 'build/vendor'

gulp.task 'index', ->
  sources = gulp.src ['build/**/*.js', 'build/**/*.css', '!build/vendor/**'], read: false
  bower_sources = gulp.src ['build/vendor/**/*.js', 'build/vendor/**/*.css'], read: false

  gulp.src 'src/index.html'
  .pipe plug.inject sources, ignorePath: 'build'
  .pipe plug.inject bower_sources, ignorePath: 'build', name: 'bower'
  .pipe gulp.dest 'build'

gulp.task 'template', ->
  gulp.src ['src/app/**/*.tpl.html']
  .pipe plug.angularTemplatecache standalone: true
  .pipe gulp.dest 'build'

gulp.task 'watch', ->
  gulp.watch 'src/**/*.less', ['less']
  gulp.watch 'src/**/*.coffee', ['coffee']
  gulp.watch 'src/index.html', ['index']
  gulp.watch 'src/**/*.tpl.html', ['template']

gulp.task 'server', ->
  gulp.src 'build'
  .pipe plug.webserver(
    livereload: true
    directoryListing: false
    open: true
  )

gulp.task 'clean', (cb) ->
  del ['build'], cb

gulp.task 'build', (cb) ->
  run('clean', ['less', 'coffee', 'bower-js', 'bower-css', 'bower-font', 'template'], 'index', cb)

gulp.task 'default', (cb) ->
  run('build', 'watch', 'server', cb)
