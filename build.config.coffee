module.exports =
  build_dir: 'build'
  compile_dir: 'bin'
  app_files:
    js: [ 'src/**/*.js', '!src/**/*.spec.js', '!src/assets/**/*.js' ]
    json: [ 'src/**/*.json' ]
    jsunit: [ 'src/**/*.spec.js' ]
    coffee: [ 'src/**/*.coffee', '!src/**/*.spec.coffee' ]
    coffeeunit: [ 'src/**/*.spec.coffee' ]
    atpl: [ 'src/app/**/*.tpl.html' ]
    ctpl: [ 'src/common/**/*.tpl.html' ]
    html: [ 'src/index.html' ]
    less: 'src/less/main.less'
  test_files:
    js: [ 'vendor/angular-mocks/angular-mocks.js' ]
  vendor_files:
    js: [
      'vendor/angular/angular.js'
      'vendor/angular-bootstrap/ui-bootstrap-tpls.min.js'
      'vendor/bower-angular-placeholders/angular-placeholders.js'
      'vendor/angular-ui-router/release/angular-ui-router.js'
      'vendor/angular-ui-utils/modules/route/route.js'
      # tk
      'vendor/jquery/dist/jquery.js'
      'vendor/bootstrap/dist/js/bootstrap.js'
      #'vendor/bootstrap/js/collapse.js'
      #'vendor/bootstrap/js/transition.js'
      'vendor/angular-flash/dist/angular-flash.js'
      'vendor/lodash/dist/lodash.js'
    ]
    css: []
    assets: [ 'vendor/font-awesome/fonts/*' ]
    fonts: [ 'vendor/font-awesome/fonts/*' ]
