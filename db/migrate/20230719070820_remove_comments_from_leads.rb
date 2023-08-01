# frozen_string_literal: true

class RemoveCommentsFromLeads < ActiveRecord::Migration[6.1]
  def change
    remove_column :leads, :comments
  end
end
