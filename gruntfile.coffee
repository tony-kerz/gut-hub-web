_ = require('lodash')

module.exports = (grunt) ->

  require('matchdep').filterDev(['grunt-*','!grunt-cli'], './package.json').forEach(grunt.loadNpmTasks)

  userConfig = require './build.config'

  taskConfig =
    pkg: grunt.file.readJSON 'package.json'
    meta:
      banner: '/**\n' +
      ' * <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n' +
      ' * <%= pkg.homepage %>\n' +
      ' *\n' +
      ' * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>\n' +
      ' * Licensed <%= pkg.licenses.type %> <<%= pkg.licenses.url %>>\n' +
      ' */\n'
    changelog:
      options:
        dest: 'CHANGELOG.md'
        template: 'changelog.tpl'
    bump:
      options:
        files: [
          'package.json'
          'bower.json'
        ]
        commit: false
        commitMessage: 'chore(release): v%VERSION%'
        commitFiles: [
            'package.json'
            'client/bower.json'
        ]
        createTag: false
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: false
        pushTo: 'origin'
    clean: [
      '<%= build_dir %>'
      '<%= compile_dir %>'
    ]
    copy:
      build_app_assets:
        files: [
          src: [ '**' ]
          dest: '<%= build_dir %>/assets/'
          cwd: 'src/assets'
          expand: true
        ]
      build_vendor_assets:
        files: [
          src: [ '<%= vendor_files.assets %>' ]
          dest: '<%= build_dir %>/assets/'
          cwd: '.'
          expand: true
          flatten: true
        ]
      build_appjs:
        files: [
          src: [ '<%= app_files.js %>' ]
          dest: '<%= build_dir %>/'
          cwd: '.'
          expand: true
        ]
      build_appjson:
        files: [
          src: [ '<%= app_files.json %>' ]
          dest: '<%= build_dir %>'
          cwd: '.'
          expand: true
        ]
      build_vendorjs:
        files: [
          src: [ '<%= vendor_files.js %>' ]
          dest: '<%= build_dir %>/'
          cwd: '.'
          expand: true
        ]
      build_vendor_fonts:
        files: [
          src: [ '<%= vendor_files.fonts %>' ]
          dest: '<%= build_dir %>/assets/fonts'
          cwd: '.'
          expand: true
        ]
      compile_assets:
        files: [
          src: [ '**' ]
          dest: '<%= compile_dir %>/assets'
          cwd: '<%= build_dir %>/assets'
          expand: true
        ]
    concat:
      build_css:
        src: [
          '<%= vendor_files.css %>'
          '<%= less.build.dest %>'
        ]
        dest: '<%= less.build.dest %>'
    compile_js:
      options:
        banner: '<%= meta.banner %>'
      src: [
        '<%= vendor_files.js %>'
        'module.prefix'
        '<%= build_dir %>/src/**/*.js'
        '<%= html2js.app.dest %>'
        '<%= html2js.common.dest %>'
        'module.suffix'
      ]
      dest: '<%= compile_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.js'
    coffee:
      source:
        options:
          bare: true
        expand: true
        cwd: '.'
        src: [ '<%= app_files.coffee %>' ]
        dest: '<%= build_dir %>'
        ext: '.js'
    ngAnnotate:
      compile:
        files: [
          src: [ '<%= app_files.js %>' ]
          cwd: '<%= build_dir %>'
          dest: '<%= build_dir %>'
          expand: true
        ]
    uglify:
      compile:
        options:
          banner: '<%= meta.banner %>'
        files:
          '<%= concat.compile_js.dest %>': '<%= concat.compile_js.dest %>'
    less:
      build:
        src: [ '<%= app_files.less %>' ]
        dest: '<%= build_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.css'
        options:
          compile: true
          compress: false
          noUnderscores: false
          noIDs: false
          zeroUnits: false
      compile:
        src: [ '<%= less.build.dest %>' ]
        dest: '<%= less.build.dest %>'
        options:
          compile: true
          compress: true
          noUnderscores: false
          noIDs: false
          zeroUnits: false
    jshint:
      src: [ '<%= app_files.js %>' ]
      test: [ '<%= app_files.jsunit %>' ]
      #gruntfile: ['Gruntfile.js']
      options:
        curly: true
        immed: true
        newcap: true
        noarg: true
        sub: true
        boss: true
        eqnull: true
      globals: {}
    coffeelint:
      options:
        max_line_length:
          value: 132
          level: 'warn'
      src:
        files:
          src: [ '<%= app_files.coffee %>' ]
      test:
        files:
          src: [ '<%= app_files.coffeeunit %>' ]
      gruntfile: ['gruntfile.coffee']
    html2js:
      app:
        options:
          base: 'src/app'
        src: [ '<%= app_files.atpl %>' ]
        dest: '<%= build_dir %>/templates-app.js'
      common:
        options:
          base: 'src/common'
        src: [ '<%= app_files.ctpl %>' ]
        dest: '<%= build_dir %>/templates-common.js'
    karma:
      options:
        configFile: '<%= build_dir %>/karma-unit.js'
      unit:
        runnerPort: 9101
        background: true
      continuous:
        singleRun: true
    index:
      build:
        dir: '<%= build_dir %>'
        src: [
          '<%= vendor_files.js %>'
          '<%= build_dir %>/src/**/*.js'
          '<%= html2js.common.dest %>'
          '<%= html2js.app.dest %>'
          '<%= vendor_files.css %>'
          '<%= less.build.dest %>'
        ]
      compile:
        dir: '<%= compile_dir %>'
        src: [
          '<%= concat.compile_js.dest %>'
          '<%= vendor_files.css %>'
          '<%= less.compile.dest %>'
        ]
    karmaconfig:
      unit:
        dir: '<%= build_dir %>'
        src: [
          '<%= vendor_files.js %>'
          '<%= html2js.app.dest %>'
          '<%= html2js.common.dest %>'
          '<%= test_files.js %>'
        ]
    delta:
      options:
        livereload: true
      gruntfile:
        files: 'gruntfile.coffee'
        tasks: [ 'coffeelint:gruntfile' ]
        options:
          livereload: false
      jssrc:
        files: [ '<%= app_files.js %>']
        tasks: [ 'jshint:src', 'karma:unit:run', 'copy:build_appjs' ]
      coffeesrc:
        files: [ '<%= app_files.coffee %>' ]
        tasks: [ 'coffeelint:src', 'coffee:source', 'karma:unit:run', 'copy:build_appjs' ]
      assets:
        files: [ 'src/assets/**/*' ]
        tasks: [ 'copy:build_assets' ]
      html:
        files: [ '<%= app_files.html %>' ]
        tasks: [ 'index:build' ]
      tpls:
        files: ['<%= app_files.atpl %>', '<%= app_files.ctpl %>' ]
        tasks: [ 'html2js' ]
      less:
        files: [ 'src/**/*.less' ]
        tasks: [ 'less:build' ]
      jsunit:
        files: [ '<%= app_files.jsunit %>' ]
        tasks: [ 'jshint:test', 'karma:unit:run' ]
        options:
          livereload: false
      coffeeunit:
        files: [ '<%= app_files.coffeeunit %>' ]
        tasks: [ 'coffeelint:test', 'karma:unit:run' ]
        options:
          livereload: false
    connect:
      server:
        options:
          port: 9000
          hostname: 'localhost'
          base: 'build'
          middleware: (connect, options) ->
            proxy = require('grunt-connect-proxy/lib/utils').proxyRequest
            console.log "middleware: options=%o", options
            return [
                proxy
                connect.static(options.base[0])
            ]
          debug: true
        proxies: [
                context: '/api'
                host: 'localhost'
                port: 3000
        ]
    phonegap:
      config:
        root: '<%= build_dir %>'
        config:
          template: 'src/phonegap/_config.xml'
          data:
            id: 'com.test.phonegap.one'
            version: '<%= pkg.version %>'
            name: '<%= pkg.name %>'
        cordova: 'src/phonegap/.cordova'
        path: '<%= build_dir %>/phonegap'
        #plugins: ['/local/path/to/plugin', 'http://eg.com/path/to/plugin.git']
        platforms: ['ios']
        #maxBuffer: 500
        verbose: false
        #releases: 'releases'
        #releaseName: ->
        #  pkg = grunt.file.readJSON('package.json')
        #  pkg.name + '-' + pkg.version
    ngconstant:
      options:
        #coffee: true,
        dest: '<%= build_dir %>/src/app/appConstant.js'
        name: '<%= pkg.name %>.constant'
        constants:
          package:
            name: '<%= pkg.name %>'
            version: '<%= pkg.version %>'
          myGlobalConstant: 'myGlobalConstantValue'
      build:
        constants:
          env:
            apiUrlRoot: 'http://localhost:9000/api'
      compile:
        constants:
          env:
            apiUrlRoot: 'https://doh.com'

  grunt.initConfig _.extend(taskConfig, userConfig)

  grunt.renameTask 'watch', 'delta'
  grunt.registerTask 'watch', [ 'build', 'karma:unit', 'delta' ]
  grunt.registerTask 'watch-base', [ 'build-base', 'configureProxies:server', 'connect', 'delta' ]

  grunt.registerTask 'default', [ 'build', 'compile' ]

  grunt.registerTask 'build-base', [
    'clean', 'ngconstant:build', 'html2js', 'jshint', 'coffeelint', 'coffee', 'less:build',
    'concat:build_css', 'copy:build_app_assets', 'copy:build_vendor_assets',
    'copy:build_appjs', 'copy:build_vendorjs', 'index:build', 'copy:build_appjson'
  ]

  grunt.registerTask 'build', ['build-base', 'karmaconfig', 'karma:continuous']
  grunt.registerTask 'compile', [
    'ngconstant:compile', 'less:compile', 'copy:compile_assets', 'ngAnnotate', 'concat:compile_js', 'uglify', 'index:compile'
  ]

  grunt.registerMultiTask 'index', 'Process index.html template', ->
    dirRE = new RegExp "^(#{grunt.config('build_dir')}|#{grunt.config('compile_dir')})\/", 'g'

    jsFiles = filterForJS(this.filesSrc).map (file) ->
      file.replace dirRE, ''

    cssFiles = filterForCSS(this.filesSrc).map (file) ->
      file.replace dirRE, ''

    grunt.file.copy('src/index.html', "#{this.data.dir}/index.html",
      process: (contents, path) ->
        grunt.template.process(contents,
          data:
            scripts: jsFiles
            styles: cssFiles
            version: grunt.config 'pkg.version'
        )
    )

  grunt.registerMultiTask 'karmaconfig', 'Process karma config templates', ->
    jsFiles = filterForJS this.filesSrc

    grunt.file.copy('karma/karma-unit.tpl.js', "#{grunt.config('build_dir')}/karma-unit.js",
      process: (contents, path) ->
        grunt.template.process(contents,
          data:
            scripts: jsFiles
        )
    )

filterForJS = (files) ->
  files.filter (file) ->
    file.match(/\.js$/)

filterForCSS = (files) ->
  files.filter (file) ->
    file.match(/\.css$/)
