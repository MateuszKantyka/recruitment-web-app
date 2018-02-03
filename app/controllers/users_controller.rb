class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = 'secret'
    @user.admin = false
    if @user.save
      redirect_to admins_path
      flash[:success] = 'User created'
    else
      flash.now[:danger] = 'Correct the field'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User updated'
      redirect_to admins_path
    else
      flash.now[:danger] = 'Correct the field'
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

  private

  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def user_params
    params.require(:user).permit(:email, :is_male, :birthday, interests_attributes: [:id, :name, :type, :_destroy])
  end
end
