angular.module('gut-hub', [
        'ui.router',
        'templates-app',
        'templates-common',
        'gut-hub.about',
        'gut-hub.home',
        'gut-hub.recipes'
    ])

    .config(function myAppConfig($stateProvider, $urlRouterProvider) {
        // default to '/home'...
        $urlRouterProvider.otherwise('/home');
    })

    // https://github.com/angular-ui/ui-router/blob/master/sample/module.js
    //
    .run(function run($rootScope, $state, $stateParams) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
    })

    .controller('app-ctrl', function AppCtrl($scope, $location) {
        // these are supposed to be global handlers
        // should we use $rootScope here or will it be same difference if controller is set at html node...?
        //
        $scope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
            console.log("$stateChangeSuccess: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o", event, toState, toParams, fromState, fromParams);

            if (angular.isDefined(toState.data.pageTitle)) {
                $scope.pageTitle = toState.data.pageTitle + ' | gut-hub';
            }
        });

        // $scope == $rootScope if this is set in right place in dom...?
        // general idea: this will catch resolve errors for entire app, should post to common alert panel...
        //
        $scope.$on('$stateChangeError', function (event, toState, toParams, fromState, fromParams, error) {
            console.log("$stateChangeSuccess: event=%o, toState=%o, toParams=%o, fromState=%o, fromParams=%o, error=%o", event, toState, toParams, fromState, fromParams, error);
        });
    })

;

