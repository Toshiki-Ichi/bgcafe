class Room < ApplicationRecord
  has_one_attached :image_rooms
  has_many :user_rooms
  has_many :users, through: :user_rooms

end
