class Phase < ApplicationRecord
  belongs_to :lead, foreign_key: :lead_id
  has_many :engineers
end

