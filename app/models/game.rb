class Game < ApplicationRecord
	has_one_attached :image_games
	belongs_to :user
	belongs_to :room
end
