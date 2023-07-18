class PhasePolicy <ApplicationPolicy
  attr_reader  :user, :phase
  def initialize(user,phase)
   @user=user
   @phase=phase
  end
  def  update?
    return true if user.super_admin?
    user.roles.exists?(name: "Business_Developer")
  end
  def create?
    update?
  end
  def destroy?
    update?
  end
end
