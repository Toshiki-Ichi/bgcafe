class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :my_image
  has_many :games
  has_many :user_rooms
  has_many :rooms, through: :user_rooms 
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :career
end
