class LeadPolicy <ApplicationPolicy
  attr_reader  :user, :lead
  def initialize(user,lead)
   @user=user
   @lead=lead
  end
  def  update?
     user.roles.exists?(name: "Business_Developer")
  end
  def create?
    user.roles.exists?(name: "Business_Developer")
  end
  def destroy?
    user.roles.exists?(name: "Business_Developer")
  end
end
