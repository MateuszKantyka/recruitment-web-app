class ApplicationController < ActionController::Base
  include Pundit
  require 'csv'
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    redirect_to(users_path)
  end
end
