class AddSaleDateToLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads, :sale_date, :date
  end
end
