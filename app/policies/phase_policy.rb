class PhasePolicy <ApplicationPolicy
  attr_reader  :user, :phase
  def initialize(user,phase)
   @user=user
   @phase=phase
  end
  def  update?
     user.roles.exists?(name: "Business_Developer")
  end
  def create?
    user.roles.exists?(name: "Business_Developer")
  end
  def destroy?
    (user.roles == "Business_Developer")
  end
end
