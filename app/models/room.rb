class Room < ApplicationRecord
  has_one_attached :image_rooms
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :user_rooms
  has_many :users, through: :user_rooms

end
