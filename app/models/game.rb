class Game < ApplicationRecord
	has_one_attached :image_games
	belongs_to :user
	belongs_to :room
	validates :game_name,:rule, presence: { message: "は空白では登録できません" }
  validates :image_games, presence: { message: "は必須です" }
	validates :user_id, presence: { message: "が必要です" }
  validates :room_id, presence: { message: "が必要です" }
end
