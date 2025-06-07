class UniqueValidation < ActiveRecord::Migration[8.0]
  def change
    add_index :players, :nickname, unique: true
    add_index :teams, :name, unique: true
    add_index :teams, :worldRanking, unique: true
    add_index :tournaments, :name, unique: true
    add_index :participants, [:tournament_id, :place], unique: true, where: "place IS NOT NULL"
  end
end
