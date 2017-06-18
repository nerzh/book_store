angular.module("bookStore")
    .controller("ratingCtrl", [ '$scope', '$rootScope', 'restReview', '$location', function ($scope, $rootScope, restReview, $location) {

        $scope.request = function(){
            restReview.create(
                {
                    review:
                    {
                        rating_points:  $scope.rating.value,
                        rating_book_id: $scope.rating.book_id,
                        rating_user_id: $scope.rating.user_id,
                        review_text:    $scope.rating.text,
                        review_theme:   $scope.rating.theme,
                        review_user_id: $scope.rating.user_id,
                        review_book_id: $scope.rating.book_id
                    }
                },
                function(response){
                    if (response.status == 200)
                    {
                        return window.location.href = '/products/' + $scope.rating.book_id;
                    }
                },
                function(error){
                    alert("Sorry! Try later.\n\n" + error.statusText + "\n\nStatus:" + error.status);
                }
            );
        };

        $scope.init_review = function (book_id, user_id) {
            $scope.rating =
            {
                value:      1,
                isReadonly: false,
                text:       '',
                user_id:       user_id,
                book_id:       book_id
            };
        };

        $scope.init_book = function (value) {
            if (value == null)
            {
                value = 1;
            }
            $scope.rating =
            {
                value:      value,
                isReadonly: true
            };
        };

        $scope.enter = function (value) {
            if (value) {
                $scope.request();
            }
        };

    }]);
