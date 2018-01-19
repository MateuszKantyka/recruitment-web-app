FactoryBot.define do
  factory :user do
    email "example@mail.com"
    password "12345678"
    is_male true
    age 23
  end
end
