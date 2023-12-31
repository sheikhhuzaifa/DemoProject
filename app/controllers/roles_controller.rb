# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.page(params[:page]).per(3)
  end

  def assign_role
    user = User.find(params[:id])

    if User.roles.keys.include?(params[:role])
      authorize Role
      user.add_role(params[:role])
      redirect_to roles_path, notice: "Role assigned successfully."
    else
      redirect_to roles_path, alert: "Invalid role selection."
    end
  end

  def remove_role
    user = User.find(params[:user_id])
    role = Role.find(params[:id])
    authorize role
    user.roles.delete(role)
    redirect_to roles_path, notice: "Role removed successfully."
  end
end
