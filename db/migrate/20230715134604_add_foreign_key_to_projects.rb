class AddForeignKeyToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :assigned_manager_id, :integer
    add_foreign_key :projects, :users, column: :assigned_manager_id
    add_column :projects, :lead_id, :integer
    add_foreign_key :projects, :leads, column: :lead_id
  end
end
