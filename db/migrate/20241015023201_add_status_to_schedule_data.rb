class AddStatusToScheduleData < ActiveRecord::Migration[7.0]
  def change
    add_column :schedule_data, :day, :integer
    add_column :schedule_data, :group1_daytime_game, :integer
    add_column :schedule_data, :group2_daytime_game, :integer
    add_column :schedule_data, :group3_daytime_game, :integer
    add_column :schedule_data, :group1_20pm_game, :integer
    add_column :schedule_data, :group2_20pm_game, :integer
    add_column :schedule_data, :group3_20pm_game, :integer
    add_column :schedule_data, :group1_21pm_game, :integer
    add_column :schedule_data, :group2_21pm_game, :integer
    add_column :schedule_data, :group3_21pm_game, :integer
    add_column :schedule_data, :group1_22pm_game, :integer
    add_column :schedule_data, :group2_22pm_game, :integer
    add_column :schedule_data, :group3_22pm_game, :integer
  end
end
