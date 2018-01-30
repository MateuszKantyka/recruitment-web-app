module UsersHelper
  def user_age(user)
    now = Time.now.utc.to_date
    now.year - user.birthday.year - ((now.month > user.birthday.month || (now.month == user.birthday.month && now.day >= user.birthday.day)) ? 0 : 1)
  end
end
