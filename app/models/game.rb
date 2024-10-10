class Game < ApplicationRecord
	has_one_attached :image_games
	belongs_to :user
	belongs_to :room
	extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :require_time
	belongs_to :capacity
	has_many :scheduledata
  has_many :groupschedules, through: :scheduledata
	validates :game_name,:rule, presence: { message: "は空白では登録できません" }
  validates :image_games, presence: { message: "は必須です" }
	validates :user_id, presence: { message: "が必要です" }
  validates :room_id, presence: { message: "が必要です" }
	validates :capacity_id, numericality: { greater_than_or_equal_to: 1, message: "は --- 以外を選択してください。" }
  validates :require_time_id, numericality: { greater_than_or_equal_to: 2, message: "は --- 以外を選択してください。" }

end
