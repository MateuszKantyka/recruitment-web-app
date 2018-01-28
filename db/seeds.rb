require 'faker'

User.create!(email: 'admin@mail.com',
             password: '1234',
             is_male: true,
             admin: true,
             birthday: '1994-08-21')

2.times do
  User.create!(email: Faker::Internet.email,
               password: Faker::Internet.password(8),
               is_male: Faker::Boolean.boolean,
               admin: false,
               birthday: Faker::Date.birthday(18, 65))
end

7.times do
  Interest.create!(name: Faker::ProgrammingLanguage.name,
                   type: 'Work',
                   user_id: Faker::Number.between(1,3))
end
