
FactoryGirl.define do

  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph(2, false, 20) }
    price { rand(1000000) }
    amount { rand(100) }
    after :create do |p|
      p.remote_cover_url = Faker::Avatar.image
      p.save
    end

    trait :test do
      category
    end

    trait :uniq do
      category_id { Category.find( Category.all[Random.rand(0...Category.all.size)] ).id }
    end

    trait :authors do
      authors { create_list( :author, Random.rand(1..3) ) }
    end

  end

end

FactoryGirl.define do

  factory :author do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    biography  { Faker::Lorem.paragraph }
  end

end

FactoryGirl.define do

  factory :category do
    sequence(:title) { |n| Faker::Lorem.word + n.to_s }
  end

end

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| n.to_s + Faker::Internet.email }
    password "password"
    password_confirmation "password"
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }

    trait :test do
      email { "email@gmail.com" }
    end

    trait :rand_with_orders do
      orders { create_list( :order, 10, :with_order_items, order_items_count: 6) }
    end

    trait :rand_with_full do
      orders { create_list( :order, 10, :with_order_items) }
      after(:create) do |user, evaluator|
        create(:shipping_address, user_id: user.id)
        create(:billing_address,  user_id: user.id)
      end
    end
  end

end

FactoryGirl.define do

  factory :order do
    credit_card

    trait :test do
      user
    end

    trait :with_order_items do
      transient do
        order_items_count 5
      end

      after(:create) do |order, evaluator|
        order.order_items = create_list(:order_item, evaluator.order_items_count, :with_rand, order_id: order.id)
      end
    end
  end

end

FactoryGirl.define do

  factory :order_item do
    quantity { rand(1..4) }

    trait :test do
      order
      book
      price { book.price }
    end

    trait :with_rand do
      book_id { Book.find( Book.all[Random.rand(0...Book.all.size)] ).id }
      price { Book.find( book_id ).price }
    end
  end

end

FactoryGirl.define do

  factory :review do
    theme { Faker::Lorem.paragraph }
    text { Faker::Lorem.paragraph(2, false, 7) }

    trait :test do
      user
      book
    end

    trait :with_rand do
      user_id { User.find( User.all[Random.rand(0...User.all.size)] ).id }
      book_id { Book.find( Book.all[Random.rand(0...Book.all.size)] ).id }
    end
  end

end

FactoryGirl.define do

  factory :rating do
    points { rand(1..10) }

    trait :test do
      user
      book
    end

    trait :with_rand do
      user_id { User.find( User.all[Random.rand(0...User.all.size)] ).id }
      book_id { Book.find( Book.all[Random.rand(0...Book.all.size)] ).id }
    end
  end

end

FactoryGirl.define do

  factory :credit_card do
    number { Faker::Business.credit_card_number.gsub(/-/, '') }
    cvv { rand(100..999) }
    exp_month { Random.rand(1..12) }
    exp_year { Random.rand(2016..3000) }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }

    trait :test do
      user
    end
  end

end

FactoryGirl.define do

  factory :billing_address do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }
    zip { Faker::Address.zip }
    country

    trait :test do
      user
    end
  end

end

FactoryGirl.define do

  factory :shipping_address do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }
    zip { Faker::Address.zip }
    country

    trait :test do
      user
    end
  end

end

FactoryGirl.define do

  factory :order_billing_address do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }
    zip { Faker::Address.zip }
    country

    trait :test do
      order
    end
  end

end

FactoryGirl.define do

  factory :order_shipping_address do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }
    zip { Faker::Address.zip }
    country

    trait :test do
      order
    end
  end

end

FactoryGirl.define do

  factory :country do
    name { Faker::Address.country }

    trait :test do
      shipping_address
      billing_address
    end
  end

end

FactoryGirl.define do

  factory :delivery do
    name { Faker::Lorem.word }
    price { Random.rand(1000..100000) }

    trait :test do
      order
    end
  end

end