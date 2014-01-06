angular.module('gut-hub.recipe')

.controller 'recipe-index-ctrl', ($scope, recipes) ->
  console.log 'recipe-index-ctrl: recipes=%o', recipes
  $scope.recipes = recipes

.controller 'recipe-get-ctrl', ($scope, recipe) ->
  console.log 'recipe-get-ctrl: recipe=%o', recipe
  $scope.recipe = recipe


