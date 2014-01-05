angular.module('gut-hub')

  # https://github.com/angular-ui/ui-router/blob/master/sample/module.js
  .run ($rootScope, $state, $stateParams)->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams
