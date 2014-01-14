angular.module('gutHub')

.config ($urlRouterProvider) ->
  # default to '/home'...
  $urlRouterProvider.otherwise '/home'

.config (flashProvider) ->
  # Support bootstrap 3.0 "alert-danger" class with error flash types
  flashProvider.errorClassnames.push 'alert-danger'

.config ($httpProvider) ->
#
#  - trap 401 responses and redirect to login
#  - mimic angular csrf behavior even when using cors in dev mode
#
#     per http://docs.angularjs.org/api/ng.$http
#
#     When performing XHR requests,
#     the $http service reads a token from a cookie (by default, XSRF-TOKEN) and
#     sets it as an HTTP header (X-XSRF-TOKEN).
#
  $httpProvider.interceptors.push ($rootScope, $q, $injector, env) ->
    request: (config) ->
      console.log "interceptor.request: config=%o", config

#      if env.mimicNgCsrf
#        csrfToken = $cookieStore.get('XSRF-TOKEN')
#        console.log "mimic-ng-csrf: csrf-token=%s", csrfToken
#        config.headers['X-XSRF-TOKEN'] = csrfToken

      config or $q.when config

    requestError: (rejection) ->
      console.log "interceptor.requestError: rejection=%o", rejection
      $q.reject rejection

    response: (response) ->
      console.log "interceptor.response: response=%o", response
      response or $q.when response

    responseError: (rejection) ->
      console.log "interceptor.responseError: rejection=%o", rejection
      if rejection.status is 401
        # temp hack matching against literal
        if rejection.config.url is 'http://localhost:3000/login'
          console.log "401 on login"
        else
          console.log "401 on non-login"
          $rootScope.$broadcast 'event:unauthorized'

          # tlk
          # can't get $state injected directly into interceptor because of cyclical dependency
          # so get $injector and call invoke() asking for $state (madness, i know)...
          # ref: http://stackoverflow.com/a/19954545/2371903
          #
          $injector.invoke ($state) ->
            $state.go 'login'

      $q.reject rejection