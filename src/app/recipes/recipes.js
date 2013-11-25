angular.module('gut-hub.recipes',
        [
            'ui.router',
            'ui.bootstrap'
        ]
    )

    //--------
    // services
    //--------

    .factory('httpRecipeService', function ($http) {
        var service = {};
        var baseUrl = '/recipes';

        service.index = function () {
            //var promise = $http.get(baseUrl);
            var promise = $http.get('recipes.index.json');
            return promise;
        };

        service.get = function (id) {
            var promise = $http.get(baseUrl + '/' + id);
            return promise;
        };

        return service;
    })

    //--------
    // states
    //--------

    .config(function config($stateProvider) {

        $stateProvider.state('recipes',
            {
                url: '/recipes',
                abstract: true,
                views: {
                    'main': {
                        templateUrl: 'recipes/recipes.tpl.html'
                    }
                },
                data: { pageTitle: 'recipes' }
            });

        $stateProvider.state('recipes.index',
            {
                url: '',
                templateUrl: 'recipes/index.tpl.html',
                controller: 'recipe-index-ctrl',
                resolve: {

                    recipes: function (httpRecipeService) {

                        var promise = httpRecipeService.index();
                        /***
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
                         ***/
                        console.log('index: promise=%o', promise);
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
    })

    //--------
    // controllers
    //--------

    .controller('recipe-index-ctrl', function ($scope, recipes) {
        $scope.recipes = recipes;
    })

    .controller('recipe-get-ctrl', function ($scope, recipe) {
        $scope.recipe = recipe;
    });