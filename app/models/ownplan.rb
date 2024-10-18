class Ownplan < ApplicationRecord
  belongs_to :room
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :frequency

  validate :validate_days
  validates :frequency_id, numericality: { greater_than_or_equal_to: 1, message: 'は --- 以外を選択してください。' }
  private

  def validate_days
    %i[day1 day2 day3 day4 day5 day6 day7].each do |day|
      value = send(day) # day1, day2, ...を取得
      if value.blank?
        errors.add(day, "はどれかを選択してください")
      elsif !%w[1 2 3 4 5 6 7 8 9].include?(value)
        errors.add(day, "は無効な値です")
      end
    end
  end
end
