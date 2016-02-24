var app = angular.module('rest', ['ngResource']);

app.factory('restReview', ['$resource', function($resource){
    return $resource('/reviews/:id/:path',
        {},
        {
            create: {method:'POST'}
        }
    );
}]);