class Scheduledata < ApplicationRecord
  belongs_to :groupschedule
  belongs_to :user
  belongs_to :room
  belongs_to :game
end