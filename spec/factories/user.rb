# FactoryGirl.define do
#
#   factory :user do
#     email { Faker::Internet.email }
#     password "password"
#     password_confirmation "password"
#
#     trait :test do
#       email { "email@gmail.com" }
#     end
#
#     trait :rand_with_orders do
#       # orders { create_list( :order, 10, :with_order_items) }
#       # orders { create(:order, :with_order_items) }
#       orders {create_list(:order, 14, :with_order_items)}
#       # create(:order, traits: [:with_order_items])
#     end
#   end
#
# end