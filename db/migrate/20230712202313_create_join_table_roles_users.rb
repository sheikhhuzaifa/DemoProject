# frozen_string_literal: true

class CreateJoinTableRolesUsers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :roles, :users do |t|
      t.index %i[role_id user_id]
      # t.index [:user_id, :role_id]
    end
  end
end
