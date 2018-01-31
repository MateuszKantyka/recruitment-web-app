module UsersHelper
  def user_age(user)
    now = Date.current

    age = now.year - user.birthday.year

    age -= 1 if user.birthday.month > now.month
    age -= 1 if now.month == user.birthday.month && now.day >= user.birthday.day

    age
  end
end
