class Ownplan < ApplicationRecord
  belongs_to :room
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :frequency

  validates :day1, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :day2, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :day3, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :day4, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :day5, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :day6, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :day7, presence: { message: "はどれかを選択してください" }, inclusion: { in: %w[1 2 3 4 5 6 7 8 9], message: "は無効な値です" }
  validates :frequency_id, numericality: { greater_than_or_equal_to: 1, message: 'は --- 以外を選択してください。' }

end
