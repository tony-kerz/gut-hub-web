argv = require('minimist')(process.argv.slice 2)
gulp = require 'gulp'
plug = require('gulp-load-plugins')()
bower = require 'main-bower-files'
run = require 'run-sequence'
del = require 'del'
lazy = require 'lazypipe'
merge = require 'merge-stream'

optStream = (file) ->
  lazy()
  .pipe plug.concat, file
  .pipe plug.rev

optJsStream = (name) ->
  optStream("#{name}.min.js")
  .pipe plug.uglify

optCssStream = (name) ->
  optStream("#{name}.min.css")
  .pipe plug.minifyCss

gulp.task 'coffee', ->
  gulp.src 'src/**/*.coffee'
  .pipe plug.coffee().on 'error', plug.util.log
  .pipe plug.if argv.optimize, plug.ngAnnotate()
  .pipe plug.if argv.optimize, optJsStream('app')()
  .pipe gulp.dest 'build'

gulp.task 'less', ->
  gulp.src 'src/less/main.less'
  .pipe plug.less()
  .pipe plug.if argv.optimize, optCssStream('app')()
  .pipe gulp.dest 'build'

gulp.task 'bower', ->

  bowerStream = (suffix, optStream, dest) ->
    gulp.src bower(filter: new RegExp "^.*\.#{suffix}$"), base: 'bower_components'
    .pipe plug.if argv.optimize, optStream
    .pipe gulp.dest dest

  js = bowerStream 'js', optJsStream('vendor')(), 'build/vendor'
  css = bowerStream 'css', optCssStream('vendor')(), 'build/vendor'
  fontDest = if argv.optimize then 'build/fonts' else 'build/vendor'
  font = bowerStream '(eot|svg|ttf|woff)', plug.flatten(), fontDest

  merge js, css, font

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
  .pipe plug.if argv.optimize, optJsStream('template')()
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
  run('clean', ['less', 'coffee', 'bower', 'template'], 'index', cb)

gulp.task 'default', (cb) ->
  run('build', 'watch', 'server', cb)
