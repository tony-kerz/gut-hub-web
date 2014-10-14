dbg = debug('app:shared:security:ctrl')

angular.module 'kerz.security'

.controller 'SecurityController', ($scope, $state, security, authentication, authorization, flash) ->

  dbg 'security-controller...'

  $scope.currentUserId = ->
    authentication.currentUserId()

  $scope.login = (user) ->
    dbg 'login: to-state', security.toState
    authentication.login(user.email, user.password).then(
      (resolution) ->
        dbg 'login: resolution=%o', resolution
        if security.toState
          $state.go security.toState
        else if security.postLoginState
          $state.go security.postLoginState

        flash.success = 'successfully logged in'
      ,
      (rejection) ->
        dbg 'login: rejection=%o', rejection
        if (rejection.status is 401)
          flash.error = "login failed"
        else
          flash.error = "unexpected error attempting to login [#{rejection.status}:#{rejection.statusText}]"
    )

  $scope.logout = ->
    authentication.logout().then(
      (resolution) ->
        if security.postLogoutState
          $state.go security.postLogoutState
        flash.success = 'successfully logged out'
      ,
      (rejection) ->
        flash.error = "logout failed [#{rejection.status}:#{rejection.statusText}]"
    )

  $scope.isAuthorized = (stateName) ->
    authentication.isAuthenticated() and authorization.isAuthorized($state.get(stateName))

  $scope.requestPasswordReset = (user) ->
    authentication.requestPassReset(user.email).then(
      (resolution) ->
        flash.success = 'Recovery instructions have been delivered.'
      ,
      (rejection) ->
        flash.error = rejection.messages[0]
    )

  $scope.recoverPassword = (user) ->
    authentication.recoverPass(user.newPass, user.confirmation, $state.params.token).then(
      (resolution) ->
        flash.success = 'Password recovery successful.'
      ,
      (rejection) ->
        flash.error = rejection.messages[0]
      )

  $scope.changePass = (user) ->
    authentication.changePass(user.password, user.confirm).then(
      (resolution) ->
        $state.go security.postLoginState
        flash.success = 'successfully changed password'
      ,
      (rejection) ->
        flash.error = rejection.messages[0]
    )
