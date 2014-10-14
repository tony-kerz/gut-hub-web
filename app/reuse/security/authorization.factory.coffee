dbg = debug('app:shared:security:authorization')

angular.module 'kerz.security'

.factory 'authorization', (authentication) ->

  requiresAuthentication: (toState) ->
    if getAuthorizedRoles(toState)
      not authentication.isAuthenticated()
    else
      false

  isAuthorized: (toState) ->
    authorizedRoles = getAuthorizedRoles(toState)
    userRoles = authentication.currentUserRoles()
    if authorizedRoles
      _.intersection(authorizedRoles, userRoles).length > 0
    else
      true

getAuthorizedRoles = (toState) ->
  toState?.data?.authorizedRoles
