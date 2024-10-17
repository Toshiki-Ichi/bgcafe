class Groupschedule < ApplicationRecord
  has_many :schedule_datas
  has_many :rooms, through: :schedule_datas
end