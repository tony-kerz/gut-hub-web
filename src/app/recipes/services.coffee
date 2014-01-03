angular.module('gut-hub.recipes')

  .factory 'httpRecipeService', ($http) ->

    #baseUrl = '/gut-hub-ui/build/src/app/recipes'
    baseUrl = 'http://localhost:3000/recipes'

    index: ->
      $http.get("#{baseUrl}.json")
      #$http.get("#{baseUrl}/recipes.index.json")
      .then (res)->
        console.log "http-recipe-service.index: res=%o", res
        res.data

    get: (id) ->
      $http.get("#{baseUrl}/#{id}.json")
      #$http.get("#{baseUrl}/recipes.get.json")
      .then (res)->
        console.log "http-recipe-service.get: res=%o", res
        res.data




