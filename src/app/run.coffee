angular.module('gut-hub')

  # https://github.com/angular-ui/ui-router/blob/master/sample/module.js
  .run ($rootScope, $state, $stateParams)->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams

  .run ($http, apiUrlRoot)->
    $http.get("#{apiUrlRoot}/dummy").then (response) ->
      console.log "dummy: response=%o", response

