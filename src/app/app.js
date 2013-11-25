angular.module('gut-hub', [
        'ui.router',
        'templates-app',
        'templates-common',
        'gut-hub.about',
        'gut-hub.home',
        'gut-hub.recipes',
        'angular-flash.service',
        'angular-flash.flash-alert-directive'
    ])

    .config(function myAppConfig($stateProvider, $urlRouterProvider) {
        // default to '/home'...
        $urlRouterProvider.otherwise('/home');
    })

    .config(function (flashProvider) {

        // Support bootstrap 3.0 "alert-danger" class with error flash types
        flashProvider.errorClassnames.push('alert-danger');

        /**
         * Also have...
         *
         * flashProvider.warnClassnames
         * flashProvider.infoClassnames
         * flashProvider.successClassnames
         */

    })
    // https://github.com/angular-ui/ui-router/blob/master/sample/module.js
    //
    .run(function run($rootScope, $state, $stateParams) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
    })

    .controller('app-ctrl', function AppCtrl($rootScope, $location, flash) {
        // these are supposed to be global handlers
        // should we use $rootScope here or will it be same difference if controller is set at html node...?
        //
        $rootScope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
            console.log("$stateChangeSuccess: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o", event, toState, toParams, fromState, fromParams);

            if (angular.isDefined(toState.data.pageTitle)) {
                $rootScope.pageTitle = toState.data.pageTitle + ' | gut-hub';
            }
        });

        // $scope == $rootScope if this is set in right place in dom...?
        // general idea: this will catch resolve errors for entire app, should post to common alert panel...
        //
        $rootScope.$on('$stateChangeError', function (event, toState, toParams, fromState, fromParams, error) {
            console.log("$stateChangeError: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o, error=%o", event, toState, toParams, fromState, fromParams, error);
            flash.error = "encountered error-code=[" + error.status + "] attempting to change from state=[" + fromState.name + "] to state=[" + toState.name + "]";

        });
    })

;

