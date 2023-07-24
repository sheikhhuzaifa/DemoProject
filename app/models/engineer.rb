# frozen_string_literal: true

class Engineer < ApplicationRecord
  belongs_to :phase, foreign_key: :phase_id
end
