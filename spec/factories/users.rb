FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example-#{n}@mail.com" }
    password '12345678'
    is_male true
    admin false
    birthday '1994-08-21'
  end
end
