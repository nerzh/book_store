# FactoryGirl.define do
#
#   factory :credit_card do
#     number { Faker::Business.credit_card_number }
#     cvv { rand(100..999) }
#     exp_date { Faker::Business.credit_card_expiry_date }
#     first_name { Faker::Name.first_name }
#     last_name  { Faker::Name.last_name }
#     user
#   end
#
# end