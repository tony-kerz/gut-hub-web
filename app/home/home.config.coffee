angular.module 'gutHub.home'

.config ($stateProvider) ->

  $stateProvider.state 'home',
    url: '/home'
    views:
      'main':
        controller: 'homeControl'
        templateUrl: 'home/home.tpl.html'
    data:
      pageTitle: 'home'
