angular.module('gut-hub')

.controller 'app-ctrl',
  ($rootScope, $location, flash) ->
    #
    # these are supposed to be global handlers
    # should we use $rootScope here or will it be same difference if controller is set at html node...?
    #
    # should these $rootScope.$on calls really be in a controller or in a config/run block?
    #
    #$rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    #  console.log "$stateChangeSuccess: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o", event, toState, toParams, fromState, fromParams

    #  if(angular.isDefined toState.data.pageTitle)
    #    $rootScope.pageTitle = "#{toState.data.pageTitle} | gut-hub"

    # $scope == $rootScope if this is set in right place in dom...?
    # general idea: this will catch resolve errors for entire app, should post to common alert panel...
    #
    #$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    #  console.log "$stateChangeError: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o, error=%o", event, toState, toParams, fromState, fromParams, error
    #  flash.error = "encountered error-code=[#{error.status}] attempting to change from state=[#{fromState.name}] to state=[#{toState.name}]"


