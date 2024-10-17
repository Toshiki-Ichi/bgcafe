class ScheduleData < ApplicationRecord
  self.table_name = "schedule_datas"
  belongs_to :groupschedule
  belongs_to :user
  belongs_to :room
  belongs_to :game
end
