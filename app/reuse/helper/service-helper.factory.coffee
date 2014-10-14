angular.module 'kerz.helper'

.factory 'serviceHelper', ($q) ->

  onlyData: (promise) ->
    promise.then(
      (resolution) -> resolution.data
      ,
      (rejection) -> $q.reject rejection.data
    )
