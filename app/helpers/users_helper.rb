module UsersHelper
  def user_age(user)
    age = Date.today.year - user.birthday.year
    age - 1 if Date.today < user.birthday + age.years
  end
end
