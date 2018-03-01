class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def destroy
    authorize User
    user = User.find(params[:id])
    if user == current_user
      flash[:danger] = "Admin can't remove himself"
    else
      user.destroy
      flash[:success] = 'User successfully destroyed'
    end
    redirect_to users_path
  end

  def send_mail
    user = User.find(params[:id])
    GreetingsMailer.send_regards(user, current_user).deliver_now
    flash[:success] = "The mail is sent to the User: #{user.email}"
    redirect_to users_path
  end

  def send_greetings_to_users
    GreetingsMailer.send_regards_to_users.deliver_now
    flash[:success] = 'The mail is sent to the all users'
    redirect_to users_path
  end

  private

  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end

end
