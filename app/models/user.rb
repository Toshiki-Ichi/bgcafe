class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :my_image
  has_many :games
  has_many :user_rooms
  has_many :rooms, through: :user_rooms 
  has_one :ownplan
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :career
  validates :career_id, numericality: { greater_than_or_equal_to: 2, message: "は --- 以外を選択してください。" }, on: :update
  validates :likes, :weakness, :note, presence: { message: "は空白では登録できません" }, on: :update
  validates :my_image, presence: { message: "は必須です" }, on: :update
  validates :nickname, presence: { message: "は必須です" }
end
