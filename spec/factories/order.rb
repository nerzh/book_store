# FactoryGirl.define do
#
#   factory :order do
#     user
#     credit_card
#
#     trait :with_order_items do
#       order_items { create_list(:order_item, 5) }
#     end
#
#       # # user_with_posts will create post data after the user has been created
#       # factory :with_order_items do
#       #   # posts_count is declared as a transient attribute and available in
#       #   # attributes on the factory, as well as the callback via the evaluator
#       #   transient do
#       #     posts_count 5
#       #   end
#       #
#       #   # the after(:create) yields two values; the user instance itself and the
#       #   # evaluator, which stores all values from the factory, including transient
#       #   # attributes; `create_list`'s second argument is the number of records
#       #   # to create and we make sure the user is associated properly to the post
#       #   after(:create) do |order, evaluator|
#       #     create_list(:order_item, evaluator.posts_count, order: order)
#       #   end
#       # end
#   end
#
# end