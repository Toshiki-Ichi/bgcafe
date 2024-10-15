class RenameOldColumnToNewColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :groupschedules, :group1, :group1_daytime
    rename_column :groupschedules, :group2, :group2_daytime
    rename_column :groupschedules, :group3, :group3_daytime
    rename_column :groupschedules, :group4, :group1_20pm
    rename_column :groupschedules, :group5, :group2_20pm
    rename_column :groupschedules, :group6, :group3_20pm
    rename_column :groupschedules, :group7, :group1_21pm
    rename_column :groupschedules, :group8, :group2_21pm
    rename_column :groupschedules, :group9, :group3_21pm
    rename_column :groupschedules, :group10, :group1_22pm
    add_column :Groupschedules, :group2_22pm, :string
    add_column :Groupschedules, :group3_22pm, :string
end