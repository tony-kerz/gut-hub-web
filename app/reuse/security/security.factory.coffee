dbg = debug('app:shared:security')

angular.module 'kerz.security'

.factory 'security', ->

  toState: null
  postLogoutState: 'home'
  postLoginState: 'home'
  homeState: 'home'
  bootstrapState: 'security'
  changePassState: 'changePass'
  preAuthStates:
    loginState: 'login'
    requestResetState: 'request-password-reset'
    recoverPassState: 'recover-password'
