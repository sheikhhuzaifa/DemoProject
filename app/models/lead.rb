# frozen_string_literal: true

class Lead < ApplicationRecord
  belongs_to :user, foreign_key: :bd_id

  has_many :phases, dependent: :destroy
  has_many :comments, as: :commentable

  has_one :project, dependent: :destroy
  update_index('leads') { self }

  scope :sort_by_client, -> { order(:client_name) }
end
