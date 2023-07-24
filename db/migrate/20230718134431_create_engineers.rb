# frozen_string_literal: true

class CreateEngineers < ActiveRecord::Migration[6.1]
  def change
    create_table :engineers do |t|
      t.string :email

      t.timestamps
    end
  end
end
