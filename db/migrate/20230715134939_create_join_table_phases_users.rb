class CreateJoinTablePhasesUsers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :phases, :users do |t|
      t.index [:phase_id, :user_id]
      t.index [:user_id, :phase_id]
    end
  end
end
