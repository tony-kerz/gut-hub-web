angular.module('gutHub')

.controller 'appControl',
  ($scope, session, flash) ->
    $scope.currentUserId = session.currentUserId

    $scope.logout = ->
      console.log "app-ctrl.logout()"
      session.logout().then(
        (resolution) ->
          flash.success = "successfully logged out..."
      ,
      (rejection) ->
        console.log "app-ctrl.logout: rejection=%o", rejection
        flash.error = "encountered issue logging out..."
      )




