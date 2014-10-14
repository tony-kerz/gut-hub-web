dbg = debug('app:shared:security:run')

angular.module 'kerz.security'

.run ($rootScope, $state, security, authentication, authorization, flash) ->

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    dbg 'state-change-start: [%s->%s] event=%o, to-state=%o', fromState.name, toState.name, event, toState

    unless toState.name is security.bootstrapState
      unless authentication.isInitialized()
        dbg 'state-change-state: initializing authentication, transition to bootstrap state'
        security.toState = toState
        security.toParams = toParams
        event.preventDefault()
        $state.go security.bootstrapState
      else if _.any(security.preAuthStates, (state) ->
          toState.name is state)
        if authentication.isAuthenticated()
          flash.success = 'already logged in'
          event.preventDefault()
      else if authorization.requiresAuthentication(toState)
        dbg 'state-change-start: authentication required, transition to login state'
        security.toState = toState
        event.preventDefault()
        $state.go security.preAuthStates.loginState
      else unless authorization.isAuthorized(toState)
        dbg 'state-change-start: not-authorized, preventing transition'
        flash.error = "unauthorized transition attempt to url [#{toState.url}]"
        event.preventDefault()
        if fromState.name is security.preAuthStates.loginState
          $state.go security.homeState

  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    dbg 'state-change-success: [%s] to-state=%o', toState.name, toState

    if toState.name is security.bootstrapState
      dbg 'state-change-success: transitioned to bootstrap state, redirecting to cached to-state=%o', security.toState
      $state.go security.toState, security.toParams

    unless toState.name is security.preAuthStates.loginState
      security.toState = null
      security.toParams = null
