class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :nickname
      t.string :realname
      t.integer :age

      t.timestamps
    end
  end
end
