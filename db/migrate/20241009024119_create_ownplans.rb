class CreateOwnplans < ActiveRecord::Migration[7.0]
  def change
    create_table :ownplans do |t|
      t.date :target_week
      t.string :day1
      t.string :day2
      t.string :day3
      t.string :day4
      t.string :day5
      t.string :day6  
      t.string :day7
      t.integer :frequency
      t.integer :one_on_one_id  
      t.references :user, foreign_key: true  
      t.references :room, foreign_key: true 
      t.timestamps
    end
  end
end
