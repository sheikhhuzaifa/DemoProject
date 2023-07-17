class CreatePhaseParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :phase_participants do |t|
      t.references :phase, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

