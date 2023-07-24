# frozen_string_literal: true

class AddPhaseIdToEngineers < ActiveRecord::Migration[6.1]
  def change
    add_column :engineers, :phase_id, :integer
    add_foreign_key :engineers, :phases, column: :phase_id
  end
end
