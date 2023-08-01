# frozen_string_literal: true

# Lead
class Lead < ApplicationRecord
  validates :client_contact, presence: true, numericality: { only_integer: true, message: "must be an integer" }

  belongs_to :user, foreign_key: :bd_id

  has_many :phases, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_one :project, dependent: :destroy

  accepts_nested_attributes_for :comments
  scope :sort_by_client, -> { order(:client_name) }

end
