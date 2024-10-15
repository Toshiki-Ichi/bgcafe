class Groupschedule < ApplicationRecord
	has_many :schedule_data
	has_many :rooms, through: :schedule_data
end
