class CreatePhaseEngineers < ActiveRecord::Migration[6.0]
  def change
    create_table :phase_engineers do |t|
      t.references :phase, foreign_key: true
      t.references :engineer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
