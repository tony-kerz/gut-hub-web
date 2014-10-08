###
  Each section or module of the site can also have its own routes. AngularJS
  will handle ensuring they are all available at run-time, but splitting it
  this way makes each module more "self-contained".
###

angular.module('gutHub.home')

.config ($stateProvider) ->

  $stateProvider.state 'home',
    url: '/home'
    views:
      'main':
        controller: 'homeControl'
        templateUrl: 'home/home.tpl.html'
    data:
      pageTitle: 'home'
