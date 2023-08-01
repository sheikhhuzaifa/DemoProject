# frozen_string_literal: true

# Phase
class Phase < ApplicationRecord
  validate :start_date_must_be_less_than_due_date
  validates :phase_type, :start_date, :due_date, presence: true
  belongs_to :lead, foreign_key: :lead_id

  has_many :engineers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    ["phase_type"]
  end

  private

  def start_date_must_be_less_than_due_date
    return unless start_date.present? && due_date.present? && start_date >= due_date

    errors.add(:start_date, "must be less than Due date")
  end
end
