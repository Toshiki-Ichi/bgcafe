class RenameScheduleDataToScheduleDatas < ActiveRecord::Migration[7.0]
  def change
    rename_table :schedule_data, :schedule_datas

  end
end
