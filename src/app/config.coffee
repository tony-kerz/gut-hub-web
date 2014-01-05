angular.module('gut-hub')

.config ($urlRouterProvider)->
  # default to '/home'...
  $urlRouterProvider.otherwise '/home'

.config (flashProvider)->
  # Support bootstrap 3.0 "alert-danger" class with error flash types
  flashProvider.errorClassnames.push 'alert-danger'

.config ($httpProvider)->
  $httpProvider.interceptors.push ($location, $rootScope, $q)->
    request: (config)->
      console.log "interceptor.request: config=%o", config
      config or $q.when config

    requestError: (rejection)->
      console.log "interceptor.requestError: rejection=%o", rejection
      $q.reject rejection

    response: (response)->
      console.log "interceptor.response: response=%o", response
      response or $q.when response

    responseError: (rejection)->
      console.log "interceptor.responseError: rejection=%o", rejection
      $q.reject rejection