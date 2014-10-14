angular.module 'kerz.login'

.config ($stateProvider) ->

  $stateProvider.state 'login',
    url: '/login'
    views:
      'main':
        templateUrl: 'reuse/login/login.tpl.html'
        controller: 'SecurityController'
    data:
      pageTitle: 'login'
