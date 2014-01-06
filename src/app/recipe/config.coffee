angular.module('gut-hub.recipe')

.config ($stateProvider) ->

  $stateProvider.state 'recipes',
    url: '/recipes'
    abstract: true
    views:
      'main':
        templateUrl: 'recipe/recipes.tpl.html'
    data:
      pageTitle: 'recipes'

  $stateProvider.state 'recipes.index',
    url: ''
    templateUrl: 'recipe/index.tpl.html'
    controller: 'recipe-index-ctrl'
    resolve:
      recipes: (httpRecipeService) ->
        console.log "state: recipes.index..."
        httpRecipeService.index()

  $stateProvider.state 'recipes.show',
    url: '/:id'
    templateUrl: 'recipe/get.tpl.html'
    controller: 'recipe-get-ctrl'
    resolve:
      recipe: (httpRecipeService, $stateParams) ->
        console.log "state: recipes.show: state-params=%o", $stateParams
        httpRecipeService.get $stateParams.id
