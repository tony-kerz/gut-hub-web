angular.module 'gutHub'

# https://github.com/angular-ui/ui-router/blob/master/sample/module.js
.run ($rootScope, $state, $stateParams, flash) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
  #$rootScope.currentUser = null
  #$rootScope.defaultState = 'home'

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    console.log "$stateChangeStart: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o", event, toState, toParams, fromState, fromParams

    unless toState.name is 'login'
      console.log "state-change-start: setting root-scope.to-state=%o", toState
      $rootScope.toState = toState

  #
  # these are supposed to be global handlers
  # should we use $rootScope here or will it be same difference if controller is set at html node...?
  #
  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    console.log "$stateChangeSuccess: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o", event, toState, toParams, fromState, fromParams

    unless toState.name is 'login'
      console.log "state-change-success: setting root-scope.to-state to null..."
      $rootScope.toState = null

    if(angular.isDefined toState.data.pageTitle)
      $rootScope.pageTitle = "#{toState.data.pageTitle} | gut-hub"

  # $scope == $rootScope if this is set in right place in dom...?
  # general idea: this will catch resolve errors for entire app, should post to common alert panel...
  #
  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    console.log "$stateChangeError: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o, error=%o", event, toState, toParams, fromState, fromParams, error
    flash.error = "encountered error-code=[#{error.status}] attempting to change from state=[#{fromState.name}] to state=[#{toState.name}]"

#.run ($http, env) ->
#  $http.get("#{env.apiUrlRoot}/dummy").then (response) ->
#    console.log "dummy: response=%o", response

# .run (session) ->
#   session.checkCurrentUser().then (resolution) ->
#     console.log "app.run: check-current-user: resolution=%o", resolution
