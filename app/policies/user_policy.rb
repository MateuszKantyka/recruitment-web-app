class UserPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end

  def admin_panel?
    user.admin?
  end
end
