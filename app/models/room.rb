class Room < ApplicationRecord
	has_one_attached :image_rooms
	has_many :room_users
  has_many :users, through: :room_users
end
