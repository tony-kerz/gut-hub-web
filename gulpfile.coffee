gulp = require 'gulp'
plug = require('gulp-load-plugins')()
bower = require 'main-bower-files'
run = require 'run-sequence'
del = require 'del'
pakij = require './package.json'
_ = require 'lodash'
optimize = false

gulp.task 'coffee', () ->
  gulp.src 'src/**/*.coffee'
    .pipe plug.coffee().on 'error', plug.util.log
    .pipe plug.if(optimize, plug.ngAnnotate())
    .pipe gulp.dest 'build'

gulp.task 'less', () ->
  gulp.src 'src/less/main.less'
  .pipe plug.less()
  .pipe plug.if(optimize, plug.rev())
  .pipe gulp.dest('build/assets')

gulp.task 'bower', () ->
  gulp.src bower(), read: true, base: 'bower_components'
  #.pipe plug.debug()
  .pipe gulp.dest 'build/vendor'

gulp.task 'index', () ->
  sources = gulp.src ['build/**/*.js', 'build/**/*.css', '!build/vendor/**'], read: false
  bower_sources = gulp.src ['build/vendor/**/*.js', 'build/vendor/**/*.css'], read: false

  gulp.src 'src/index.html'
  .pipe plug.inject sources, ignorePath: 'build'
  .pipe plug.inject bower_sources, ignorePath: 'build', name: 'bower'
  .pipe gulp.dest 'build'

gulp.task 'template', () ->
  gulp.src ['src/app/**/*.tpl.html']
  .pipe plug.angularTemplatecache standalone: true
  .pipe gulp.dest 'build'

gulp.task 'watch', () ->
  gulp.watch 'src/**/*.less', ['less']
  gulp.watch 'src/**/*.coffee', ['coffee']
  gulp.watch 'src/index.html', ['index']
  gulp.watch 'src/**/*.tpl.html', ['template']

gulp.task 'server', () ->
  gulp.src 'build'
    .pipe plug.webserver(
      livereload: true
      directoryListing: false
      open: true
    )

gulp.task 'clean', (cb) ->
  del ['build'], cb

gulp.task 'build', (cb) ->
  run('clean', 'less', 'coffee', 'bower', 'template', 'index', cb)

gulp.task 'compile', () ->
  optimize = true
  run('build')

gulp.task 'default', () ->
  run('build', 'watch', 'server')
