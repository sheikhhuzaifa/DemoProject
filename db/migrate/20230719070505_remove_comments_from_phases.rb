# frozen_string_literal: true

class RemoveCommentsFromPhases < ActiveRecord::Migration[6.1]
  def change
    remove_column :phases, :comments
  end
end
