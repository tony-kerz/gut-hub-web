angular.module('gut-hub.recipes')

    .config(function config($stateProvider) {

        $stateProvider.state('recipes',
            {
                url: '/recipes',
                abstract: true,
                templateUrl: 'recipes/recipes.tpl.html',
                data: { pageTitle: 'recipes' }
            });

        $stateProvider.state('recipes.index',
            {
                url: '',
                templateUrl: 'recipes/index.tpl.html',
                controller: 'recipe-index-ctrl',
                resolve: {

                    recipes: function (httpRecipeService) {

                        var promise = httpRecipeService.index()
                            .then(
                            function (data) {
                                console.log("success: data=%o", data);
                            },
                            function (reason) {
                                console.log("failure: reason=%o", reason);
                            },
                            function (update) {
                                console.log("notify: update=%o", update);
                            }
                        );

                        return promise;
                    }
                }
            });

        $stateProvider.state('recipes.show',
            {
                url: '/recipes/:id',
                templateUrl: 'recipe/get.tpl.html',
                controller: 'recipe-get-ctrl',
                resolve: {

                    recipe: function (httpRecipeService, $stateParams) {

                        var promise = httpRecipeService.get($stateParams.id)
                            .then(
                            function (data) {
                                console.log("success: data=%o", data);
                            },
                            function (reason) {
                                console.log("failure: reason=%o", reason);
                            },
                            function (update) {
                                console.log("notify: update=%o", update);
                            }
                        );

                        return promise;
                    }
                }
            });
    });
