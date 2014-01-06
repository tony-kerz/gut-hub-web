angular.module('gut-hub.session')

.config ($stateProvider) ->

  $stateProvider.state 'login',
    url: '/login'
    views:
      'main':
        templateUrl: 'session/login.tpl.html'
    data:
      pageTitle: 'login'