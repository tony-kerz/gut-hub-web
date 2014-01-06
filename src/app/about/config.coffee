angular.module('gut-hub.about')

.config ($stateProvider) ->

  $stateProvider.state 'about',
    url: '/about'
    views:
      'main':
        controller: 'about-ctrl'
        templateUrl: 'about/about.tpl.html'
    data:
      pageTitle: 'what is it?'
