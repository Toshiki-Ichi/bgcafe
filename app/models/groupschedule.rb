class Groupschedule < ApplicationRecord
  has_many :schedule_datas
  has_many :rooms, through: :schedule_datas

  validates :day, presence: true, inclusion: { in: 1..7, message: "は1から7の間である必要があります" }
  validates :room_id, presence: true
end