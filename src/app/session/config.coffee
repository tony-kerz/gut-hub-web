angular.module('gut-hub.session')

.config ($stateProvider) ->

  $stateProvider.state 'login',
    url: '/login'
    views:
      'main':
        templateUrl: 'session/login.tpl.html'
        controller: 'login-ctrl'
    data:
      pageTitle: 'login'