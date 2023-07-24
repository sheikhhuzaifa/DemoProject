# frozen_string_literal: true

class CreatePhases < ActiveRecord::Migration[6.1]
  def change
    create_table :phases do |t|
      t.string :phase_type
      t.date :start_date
      t.date :due_date
      t.text :comments
      t.date :creation_date
      t.boolean :completed
      t.date :completed_date

      t.timestamps
    end
  end
end
