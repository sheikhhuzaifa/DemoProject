class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin!

  def index
    @users = User.all
  end

  def assign_role
    user = User.find(params[:id])

    user.add_role(params[:role])
    redirect_to roles_path, notice: "Role assigned successfully."
  end

  def remove_role
    user = User.find(params[:user_id])
    role = Role.find(params[:id])

    user.roles.delete(role)
    redirect_to roles_path, notice: "Role removed successfully."
  end

  private

  def authorize_super_admin!
    unless current_user.super_admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
