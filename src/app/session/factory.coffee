angular.module('gut-hub.session')

.factory 'sessionService', ($location, $http, $q, apiUrlRoot) ->

  login: (email, password) ->
    $http.post("#{apiUrlRoot}/login"
      user:
        email: email
        password: password
    )
    .then (response) ->
      @currentUser = response.data.user

      if @isAuthenticated()
        $location.path '/about'

  logout: (redirectTo) ->
    $http.post("#{apiUrlRoot}/logout")
    .then (response) ->
      @currentUser = null
      $location.path redirectTo

  register: (email, password, confirm_password) ->
    $http.post("#{apiUrlRoot}/users.json"
      user:
        email: email
        password: password
        password_confirmation: confirm_password
    )
    .then (response) ->
      @currentUser = response.data
      if @isAuthenticated()
        $location.path '/about'

  requestCurrentUser: ->
    if @isAuthenticated()
      $q.when @currentUser
    else
      $http.get("#{apiUrlRoot}/current_user")
      .then (response) ->
        @currentUser = response.data.user

  currentUser: null

  isAuthenticated: ->
    @currentUser
