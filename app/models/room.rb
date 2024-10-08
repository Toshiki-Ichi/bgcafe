class Room < ApplicationRecord
  has_one_attached :image_rooms
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :games
  has_many :ownplans

  validates :room_name,:contact, presence: { message: "は空白では登録できません" }
  validates :creator_id,presence: true
  validates :image_rooms, presence: { message: "は必須です" }
  validates :creator_id, presence: { message: "は必須です" }
end
