# frozen_string_literal: true

class PhasePolicy < ApplicationPolicy
  attr_reader :user, :phase

  def initialize(user, phase)
    @user = user
    @phase = phase
  end

  def update?
    return true if user.super_admin?

    user.roles.exists?(name: "Business_Developer") || user.roles.exists?(name: "Technical_Manager")
  end

  def create?
    return true if user.super_admin?

    user.roles.exists?(name: "Business_Developer")
  end

  def destroy?
    create?
  end
end
