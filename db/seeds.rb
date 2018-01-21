require 'faker'

User.create!(email: 'example@mail.com',
             password: '12345678',
             is_male: true,
             birthday: '1994-08-21')

10.times do
  User.create!(email: Faker::Internet.email,
               password: Faker::Internet.password(8),
               is_male: Faker::Boolean.boolean,
               birthday: Faker::Date.birthday(18, 65))
end
