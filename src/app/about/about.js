angular.module('gut-hub.about', [
        'ui.router',
        'placeholders',
        'ui.bootstrap'
    ])

    .config(function config($stateProvider) {
        $stateProvider.state('about', {
            url: '/about',
            views: {
                "main": {
                    controller: 'about-ctrl',
                    templateUrl: 'about/about.tpl.html'
                }
            },
            data: { pageTitle: 'What is It?' }
        });
    })

    .controller('about-ctrl', function ($scope) {
        // This is simple a demo for UI Bootstrap.
        $scope.dropdownDemoItems = [
            "The first choice!",
            "And another choice for you.",
            "but wait! A third!"
        ];
    })

;
