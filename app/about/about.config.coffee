angular.module 'gutHub.about'

.config ($stateProvider) ->

  $stateProvider.state 'about',
    url: '/about'
    views:
      'main':
        controller: 'aboutControl'
        templateUrl: 'about/about.tpl.html'
    data:
      pageTitle: 'what is it?'
