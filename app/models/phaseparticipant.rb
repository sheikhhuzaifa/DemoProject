class PhaseParticipant < ApplicationRecord
  belongs_to :phase, foreign_key: :phase_id
  belongs_to :user, foreign_key: :engineer_id
end
