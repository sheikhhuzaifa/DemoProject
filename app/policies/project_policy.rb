# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def assign_manager?
    return true if user.super_admin?

    # user.roles.map(&:name).include?("Business_Developer") this query is more costly as compared to below line
    user.roles.exists?(name: "Business_Developer")
  end
end
