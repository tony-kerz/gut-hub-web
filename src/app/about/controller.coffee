angular.module('gut-hub.about')

.controller 'about-ctrl', ($scope) ->
  $scope.dropdownDemoItems =
    [
      "The first choice!"
      "And another choice for you."
      "but wait! A third!"
    ]