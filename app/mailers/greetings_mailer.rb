class GreetingsMailer < ActionMailer::Base
  def send_regards(user, current_user)
    @user = user
    @current_user = current_user
    mail(to: @user.email, subject: 'Regards')
  end
end