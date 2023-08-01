# frozen_string_literal: true

class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.string :project_name
      t.string :client_name
      t.string :client_address
      t.string :client_email
      t.string :client_contact
      t.string :platform_used
      t.text :comments
      t.string :test_type

      t.timestamps
    end
  end
end
