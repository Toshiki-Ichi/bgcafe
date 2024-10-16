class CreateScheduleData < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_data do |t|
      t.references :groupschedule, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
