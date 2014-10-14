angular.module 'gutHub.recipe'

.controller 'recipeIndexControl',
  ($scope, recipes, session) ->
    console.log 'recipe-index-ctrl: recipes=%o', recipes
    $scope.recipes = recipes
    #cu = session.currentUser()
    #cu.email = 'jerked'

.controller 'recipeGetControl',
  ($scope, recipe) ->
    console.log 'recipe-get-ctrl: recipe=%o', recipe
    $scope.recipe = recipe
