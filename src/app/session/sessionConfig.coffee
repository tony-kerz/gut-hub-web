angular.module('gutHub.session')

.config ($stateProvider) ->

  $stateProvider.state 'login',
    url: '/login'
    views:
      'main':
        templateUrl: 'session/login.tpl.html'
        controller: 'loginControl'
    data:
      pageTitle: 'login'