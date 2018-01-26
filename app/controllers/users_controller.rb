class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      flash[:danger] = "Admin can't remove himself"
    else
      user.destroy
      flash[:success] = "User successfully destroyed"
    end
    redirect_to users_path
  end

  private

  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end
end
