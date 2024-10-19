class Groupschedule < ApplicationRecord
  has_many :schedule_datas
  has_many :rooms, through: :schedule_datas

  validates :day, presence: true, inclusion: { in: 1..7, message: "は1から7の間である必要があります" }
  validates :room_id, presence: true

  validate :unique_ids

  private

  def unique_ids
    # 設定したグループ名のリスト
    time = %w[daytime 20pm 21pm 22pm]

    time.each do |time_slot|
      # 各groupカラムのIDを配列として取得
      group1_ids = (send("group1_#{time_slot}") || nil).to_s.split(",").map(&:to_i)
      group2_ids = (send("group2_#{time_slot}") || nil).to_s.split(",").map(&:to_i)
      group3_ids = (send("group3_#{time_slot}") || nil).to_s.split(",").map(&:to_i)

      # すべてのIDを結合し1つの配列にする
      all_ids = group1_ids + group2_ids + group3_ids

      # 重複があればバリデーションエラー
      if all_ids.uniq.length != all_ids.length
        errors.add(:base, "同じ時間に重複したユーザーがあります")
      end
    end
  end
end