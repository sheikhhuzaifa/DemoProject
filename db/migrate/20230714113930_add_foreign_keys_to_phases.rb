# frozen_string_literal: true

class AddForeignKeysToPhases < ActiveRecord::Migration[6.1]
  def change
    add_column :phases, :assignee_id, :integer
    add_foreign_key :phases, :users, column: :assignee_id
    add_column :phases, :lead_id, :integer
    add_foreign_key :phases, :leads, column: :lead_id
  end
end
