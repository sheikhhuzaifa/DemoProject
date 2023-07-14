class RolesController < ApplicationController
  before_action :authenticate_user!
  rescue_from   Pundit::NotAuthorizedError ,with: :handle_not_authorized

  def index
    @users = User.all
  end

  def assign_role
    user = User.find(params[:id])
    role = Role.find_by(name: params[:role])
    role_id = role.id
    authorize role


    user.add_role(params[:role])
    redirect_to roles_path, notice: "Role assigned successfully."
  end

  def remove_role
    user = User.find(params[:user_id])
    role = Role.find(params[:id])
    authorize role
    user.roles.delete(role)
    redirect_to roles_path, notice: "Role removed successfully."
  end

  private
  def handle_not_authorized(exception)
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end


end
