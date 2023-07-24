# frozen_string_literal: true

# Phase
class Phase < ApplicationRecord
  belongs_to :lead, foreign_key: :lead_id

  has_many :engineers, dependent: :destroy
  has_many :comments, as: :commentable
end
