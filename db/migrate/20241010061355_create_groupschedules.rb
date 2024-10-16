class CreateGroupschedules < ActiveRecord::Migration[7.0]
  def change
    create_table :groupschedules do |t|
      t.integer :day
      t.string :group1
      t.string :group2
      t.string :group3
      t.string :group4
      t.string :group5
      t.string :group6
      t.string :group7
      t.string :group8
      t.string :group9
      t.string :group10

      t.timestamps
    end
  end
end
