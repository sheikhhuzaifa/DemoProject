class Project < ApplicationRecord
  belongs_to :lead, foreign_key: :lead_id
  belongs_to :user, foreign_key: :assigned_manager_id
end
