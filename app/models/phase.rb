class Phase < ApplicationRecord
  belongs_to :lead, foreign_key: :lead_id
  belongs_to :user, foreign_key: :assignee_id
end

