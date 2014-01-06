angular.module('gut-hub.recipes')

.config ($stateProvider) ->

  $stateProvider.state 'recipes',
    url: '/recipes'
    abstract: true
    views:
      'main':
        templateUrl: 'recipes/recipes.tpl.html'
    data:
      pageTitle: 'recipes'

  $stateProvider.state 'recipes.index',
    url: ''
    templateUrl: 'recipes/index.tpl.html'
    controller: 'recipe-index-ctrl'
    resolve:
      recipes: (httpRecipeService) ->
        console.log "state: recipes.index..."
        httpRecipeService.index()

  $stateProvider.state 'recipes.show',
    url: '/:id'
    templateUrl: 'recipes/get.tpl.html'
    controller: 'recipe-get-ctrl'
    resolve:
      recipe: (httpRecipeService, $stateParams) ->
        console.log "state: recipes.show: state-params=%o", $stateParams
        httpRecipeService.get $stateParams.id
