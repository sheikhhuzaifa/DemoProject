# frozen_string_literal: true

class LeadPolicy < ApplicationPolicy
  attr_reader :user, :lead

  def initialize(user, lead)
    @user = user
    @lead = lead
  end

  def update?
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
