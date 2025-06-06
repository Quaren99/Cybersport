class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :place
      t.integer :prize

      t.timestamps
    end
  end
end
