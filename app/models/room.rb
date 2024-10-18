class Room < ApplicationRecord
  has_secure_password
  has_one_attached :image_rooms
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :games
  has_many :ownplans
  has_many :schedule_datas
  has_many :groupschedules, through: :schedule_datas

  validates :room_name, :contact, :summary, presence: { message: 'は空白では登録できません' }
  validates :image_rooms, presence: { message: 'は必須です' }
  validates :password, presence: { message: 'は必須です' },
                     length: { minimum: 6, message: 'は6文字以上である必要があります' },
                     format: { with: /\A(?=.*[a-z])(?=.*[0-9]).+\z/, message: 'は小文字の英字と数字を含む必要があります' }
end