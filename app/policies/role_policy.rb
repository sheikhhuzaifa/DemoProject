class RolePolicy <ApplicationPolicy
     attr_reader  :user, :role
     def initialize(user,role)
      @user=user
      @role=role
     end
     def remove_role?
      user.super_admin?
     end
     def assign_role?
        remove_role?
     end
end
