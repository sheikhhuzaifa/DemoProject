# frozen_string_literal: true

# Enginner
class Engineer < ApplicationRecord
  belongs_to :phase
  validates :email, presence: true
end
