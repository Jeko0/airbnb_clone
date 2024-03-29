FactoryBot.define do
  factory :property do
    user 
    name { "MyString" }
    headline { "MyString" }
    description { "MyText" }
    address_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country_code { Faker::Address.country_code }
    average_rating {Faker::Number.decimal(l_digits: 1) }
    latitude { 1.5 }
    longitude { 1.5 }
  end
end
