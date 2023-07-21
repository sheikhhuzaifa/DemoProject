class AddSaleToLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads, :sale, :boolean, default: false
  end
end
