class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    if current_user.admin
      respond_to do |format|
        format.html
        format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
      end
    end
  end

  def new
    authorize User
    @user = User.new
  end

  def create
    authorize User
    @user = User.new(user_params)
    @user.password = 'secret'
    @user.admin = false
    if @user.save
      redirect_to admins_path
      flash[:success] = 'User created'
    else
      flash.now[:danger] = 'There were some errors when saving the user'
      render 'new'
    end
  end

  def edit
    authorize User
    @user = User.find(params[:id])
  end

  def update
    authorize User
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User updated'
      redirect_to admins_path
    else
      flash.now[:danger] = 'There were some errors when saving the user'
      render 'edit'
    end
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

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :is_male, :birthday, :avatar, interests_attributes: %I[id name type _destroy])
  end
end
