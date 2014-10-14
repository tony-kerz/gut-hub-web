dbg = debug('app:shared:security:authentication')

angular.module 'kerz.security'

.factory 'authentication', ($http, $q, serviceHelper) ->

  _currentUser = null
  _initialized = false

  login: (email, password) ->
    $http.post('/api/sessions',
      user:
        email: email
        password: password
    ).then (resolution) ->
      dbg 'login: resolution=%o', resolution
      _currentUser = resolution.data.user

  logout: ->
    $http.delete('/api/sessions/current').then (resolution) ->
      dbg 'logout: resolution=%o', resolution
      _currentUser = null

  requestPassReset: (email) ->
    serviceHelper.onlyData $http.post('/api/users/send_password_reset_instructions',
      email: email
    )

  recoverPass: (password, confirmation, token) ->
    serviceHelper.onlyData $http.put('/api/users/recover_password',
      user:
        password: password
        password_confirmation: confirmation
        reset_password_token: token
    )

  changePass: (password, confirmation) ->
    serviceHelper.onlyData $http.put('/api/users/password_reset',
      new: password
      confirmation: confirmation
    )

  currentUserId: ->
    _currentUser?.email

  initCurrentUser: ->
    dbg 'init-current-user'
    $http.get('/api/sessions/current').then (resolution) ->
      dbg 'init-current-user: resolution=%o', resolution
      _currentUser = resolution.data.user
      _initialized = true

  isAuthenticated: ->
    _currentUser

  currentUserRoles: ->
    _currentUser?.roles

  isInitialized: ->
    _initialized
