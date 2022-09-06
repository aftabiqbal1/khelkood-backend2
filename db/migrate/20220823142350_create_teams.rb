class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :matches_played
      t.integer :wins
      t.integer :loses
      t.integer :draw
      t.float :win_average

      t.timestamps
    end
  end
end
