class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @users = User.all
  end

  private

  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end
end
