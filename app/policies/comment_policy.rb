# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    return true if user.super_admin?

    user.roles.exists?(name: "Technical_Manager")
  end
end
