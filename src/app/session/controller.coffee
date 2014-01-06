angular.module('gut-hub.session')

.controller 'login-ctrl', ($scope, session) ->

  $scope.login = (user) ->
    console.log 'login-ctrl: user=%o', user
    session.login user.email, user.password




