# frozen_string_literal: true

# Project
class Project < ApplicationRecord
  belongs_to :lead, foreign_key: :lead_id
  belongs_to :user, foreign_key: :assigned_manager_id

  has_many :comments, as: :commentable, dependent: :destroy
  # def initialize(project)
  #   @project = project
  # end

  # def project_name
  #   self.project_name
  # end
end
