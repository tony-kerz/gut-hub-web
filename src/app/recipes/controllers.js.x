angular.module('gut-hub.recipes')

    .controller('recipe-index-ctrl', function ($scope, recipes) {
        $scope.recipes = recipes;
    })

    .controller('recipe-get-ctrl', function ($scope, recipe) {
        $scope.recipe = recipe;
    });


