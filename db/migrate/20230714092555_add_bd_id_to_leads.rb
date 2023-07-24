# frozen_string_literal: true

class AddBdIdToLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads, :bd_id, :integer
    add_foreign_key :leads, :users, column: :bd_id
  end
end
