class AdminsController < ApplicationController
  before_action :require_login, if: -> { !user_signed_in? }
  before_action :user_not_authorize, if: -> { !current_user.admin? }

  def index
    @users = User.all
  end

  private

  def require_login
    redirect_to new_user_session_path
  end

  def user_not_authorize
    redirect_to users_path
  end
end
