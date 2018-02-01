class UserPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end

  def index?
    user.admin?
  end
end
