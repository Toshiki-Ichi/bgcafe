class ScheduleData < ApplicationRecord
  self.table_name = "schedule_datas"
  belongs_to :groupschedule
  belongs_to :user
  belongs_to :room
  belongs_to :game

  validates :day, presence: true, inclusion: { in: 1..7, message: "は1から7の間である必要があります" }
  validates :room_id, presence: true
end
