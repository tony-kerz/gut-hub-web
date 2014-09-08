angular.module('gutHub.recipe')

.factory 'httpRecipeService', ($http, env) ->

  #baseUrl = '/gut-hub-ui/build/src/app/recipes'
  baseUrl = "#{env.apiUrlRoot}/recipes"

  index: ->
    $http.get("#{baseUrl}")
    #$http.get("#{baseUrl}/recipes.index.json")
    .then (resolution)->
      console.log "http-recipe-service.index: success-result=%o", resolution
      resolution.data

  get: (id) ->
    $http.get("#{baseUrl}/#{id}")
    #$http.get("#{baseUrl}/recipes.get.json")
    .then (resolution)->
      console.log "http-recipe-service.get: resolution=%o", resolution
      resolution.data
