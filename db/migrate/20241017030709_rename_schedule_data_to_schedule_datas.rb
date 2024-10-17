class RenameScheduleDataToScheduleDatas < ActiveRecord::Migration[7.0]
  def change
    rename_table :scheduleDatas, :schedule_datas

  end
end
