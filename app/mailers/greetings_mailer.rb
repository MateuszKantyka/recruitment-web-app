class GreetingsMailer < ApplicationMailer
  def send_regards(user, current_user)
    @user = user
    @current_user = current_user
    mail(to: @user.email, subject: 'Regards')
  end

  def send_regards_to_users
    users = User.all
    mail(to: users, subject: 'Regards')
  end
end