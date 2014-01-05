angular.module('gut-hub')

.config ($stateProvider, $urlRouterProvider)->
  # default to '/home'...
  $urlRouterProvider.otherwise '/home'

.config (flashProvider)->
  # Support bootstrap 3.0 "alert-danger" class with error flash types
  flashProvider.errorClassnames.push 'alert-danger'
