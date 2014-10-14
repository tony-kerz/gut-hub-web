angular.module 'gutHub.about'

.controller 'aboutControl',
  ($scope) ->
    $scope.dropdownDemoItems =
      [
        "The first choice!"
        "And another choice for you."
        "but wait! A third!"
      ]
