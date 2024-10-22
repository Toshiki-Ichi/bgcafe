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
  validate :validate_password
  private

  def validate_password
    # 新規作成の場合のみバリデーションを実施
    if new_record?
      if password.blank?
        errors.add(:password, 'は必須です')
      elsif password.length < 6
        errors.add(:password, 'は6文字以上である必要があります')
      elsif !/\A(?=.*[a-z])(?=.*[0-9]).+\z/.match?(password)
        errors.add(:password, 'は小文字の英字と数字を含む必要があります')
      end
    end
  end
end