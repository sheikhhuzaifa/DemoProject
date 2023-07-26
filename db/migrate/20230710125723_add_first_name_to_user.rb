# frozen_string_literal: true

class AddFirstNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string, null: false, default: ""
    add_column :users, :lastname, :string, null: false, default: ""
  end
end
