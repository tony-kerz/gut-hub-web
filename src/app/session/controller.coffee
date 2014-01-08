angular.module('gut-hub.session')

.controller 'login-ctrl',
  ($scope, session, flash, $rootScope, $state) ->
    $scope.login = (user) ->
      console.log 'login-ctrl: user=%o', user
      session.login(user.email, user.password).then(
        (resolution) ->
          console.log "login-then: resolution=%o", resolution

          toState = $rootScope.toState
          if toState
            console.log "login-ctrl: toState=%o", toState
            $state.go toState
      ,
      (rejection) ->
        console.log "login-then: rejection=%o", rejection
        flash.error = 'login failed'
      )




