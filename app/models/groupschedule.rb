class Groupschedule < ApplicationRecord
  has_many :schedule_data, class_name: 'ScheduleData'
  has_many :rooms, through: :schedule_data
end