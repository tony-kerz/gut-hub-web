dbg = debug('app:shared:security:config')

angular.module 'kerz.security'

.config ($httpProvider) ->

  $httpProvider.interceptors.push ($rootScope, $q, $injector) ->
    request: (config) ->
      config or $q.when config

    requestError: (rejection) ->
      dbg 'interceptor.requestError: rejection=%o', rejection
      $q.reject rejection

    response: (response) ->
      response or $q.when response

    responseError: (rejection) ->
      dbg 'interceptor.responseError: rejection=%o', rejection

      if rejection.status is 401
        # can't get $state injected directly into interceptor because of cyclical dependency
        # so get $injector and call invoke() asking for $state...
        # ref: http://stackoverflow.com/a/19954545/2371903
        #
        $injector.invoke ($state, security) ->
          dbg 'interceptor.responseError: state=%o, security=%o', $state, security
          if $state.current.name is security.preAuthStates.loginState
            dbg 'interceptor.responseError: 401 on login'
          else
            dbg 'interceptor.responseError: 401 on non-login'
            $rootScope.$broadcast 'event:unauthorized'
            $state.go security.preAuthStates.loginState

      $q.reject rejection

.config ($stateProvider) ->

  $stateProvider
   .state 'security',
     resolve:
       bootstrap: (authentication) ->
         dbg 'security.resolve(bootstrap)...'
         authentication.initCurrentUser()
