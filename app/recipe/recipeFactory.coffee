angular.module('gutHub.recipe')

.factory 'httpRecipeService', ($http) ->

  baseUrl = "/recipes"

  index: ->
    $http.get("#{baseUrl}")
    .then (resolution)->
      console.log "http-recipe-service.index: success-result=%o", resolution
      resolution.data

  get: (id) ->
    $http.get("#{baseUrl}/#{id}")
    .then (resolution)->
      console.log "http-recipe-service.get: resolution=%o", resolution
      resolution.data
