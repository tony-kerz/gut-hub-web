angular.module('gut-hub.recipes')

    .factory('httpRecipeService', function ($http) {
        var service = {};
        var baseUrl = '/recipes';

        service.index = function () {
            var promise = $http.get(baseUrl);
            return promise;
        };

        service.get = function (id) {
            var promise = $http.get(baseUrl + '/' + id);
            return promise;
        };

        return service;
    });


