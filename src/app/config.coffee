angular.module('gut-hub')

.config ($urlRouterProvider)->
  # default to '/home'...
  $urlRouterProvider.otherwise '/home'

.config (flashProvider)->
  # Support bootstrap 3.0 "alert-danger" class with error flash types
  flashProvider.errorClassnames.push 'alert-danger'

.config ($httpProvider)->
  $httpProvider.interceptors.push ($rootScope, $q, $injector)->
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
      if rejection.status is 401
        $rootScope.$broadcast 'event:unauthorized'

        # tlk
        # can't get $state injected directly into interceptor because of cyclical dependency
        # so get $injector and call invoke() asking for $state (madness, i know)...
        # ref: http://stackoverflow.com/a/19954545/2371903
        #
        $injector.invoke ($state)->
          $state.go "about"

      $q.reject rejection