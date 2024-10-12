class RenameOldColumnToNewColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :groupschedules, :group1, :group1_am
    rename_column :groupschedules, :group2, :group2_am
    rename_column :groupschedules, :group3, :group3_am
    rename_column :groupschedules, :group4, :group1
    rename_column :groupschedules, :group5, :group2
    rename_column :groupschedules, :group6, :group3
    rename_column :groupschedules, :group7, :group4
    rename_column :groupschedules, :group8, :group5
    rename_column :groupschedules, :group9, :group6
    rename_column :groupschedules, :group10, :group7

  end
end