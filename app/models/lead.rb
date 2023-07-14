class Lead < ApplicationRecord
  belongs_to :user, foreign_key: :bd_id
  has_many :phases
end
