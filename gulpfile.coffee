gulp = require 'gulp'
less = require 'gulp-less'
rev = require 'gulp-rev'
gulpIf = require 'gulp-if'
server = require 'gulp-webserver'
inject = require 'gulp-inject'
coffee = require 'gulp-coffee'
util = require 'gulp-util'
debug = require 'gulp-debug'
bower = require 'main-bower-files'
run = require 'run-sequence'
del = require 'del'
pakij = require './package.json'
_ = require 'lodash'
optimize = false

gulp.task 'coffee', () ->
  gulp.src 'src/**/*.coffee'
    .pipe coffee().on 'error', util.log
    .pipe gulp.dest 'build'

gulp.task 'less', () ->
  gulp.src 'src/less/main.less'
  .pipe less()
  .pipe gulpIf(optimize, rev())
  .pipe gulp.dest('build/assets')

gulp.task 'bower', () ->
  gulp.src bower(), read: true, base: 'bower_components'
  .pipe debug()
  .pipe gulp.dest 'build/vendor'

gulp.task 'index', () ->
  sources = gulp.src ['build/**/*.js', 'build/**/*.css', '!build/vendor/**'], read: false
  bower_sources = gulp.src ['build/vendor/**/*.js', 'build/vendor/**/*.css'], read: false

  gulp.src 'src/index.html'
  .pipe inject sources, ignorePath: 'build'
  .pipe inject bower_sources, ignorePath: 'build', name: 'bower'
  .pipe gulp.dest 'build'

gulp.task 'watch', () ->
  gulp.watch 'src/**/*.less', ['less']
  gulp.watch 'src/**/*.coffee', ['coffee']
  gulp.watch 'src/index.html', ['index']

gulp.task 'server', () ->
  gulp.src 'build'
    .pipe server(
      livereload: true
      directoryListing: false
      open: true
    )

gulp.task 'clean', (cb) ->
  del ['build'], cb

gulp.task 'build', (cb) ->
  run('clean', 'less', 'coffee', 'bower', 'index', cb)

gulp.task 'compile', () ->
  optimize = true
  run('build')

gulp.task 'default', () ->
  run('build', 'watch', 'server')
