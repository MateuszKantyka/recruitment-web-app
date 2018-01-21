FactoryBot.define do
  factory :user do
    email 'example@mail.com'
    password '12345678'
    is_male true
    birthday '1994-08-21'
  end
end
