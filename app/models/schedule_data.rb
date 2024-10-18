class ScheduleData < ApplicationRecord
  self.table_name = "schedule_datas"
  belongs_to :groupschedule
  belongs_to :user
  belongs_to :room
  belongs_to :game

  validates :day, presence: true, inclusion: { in: 1..7, message: "は1から7の間である必要があります" }
  validates :room_id, presence: true

  validate :validate_numericality_for_games

  private
  
  def validate_numericality_for_games
    (1..3).each do |group_number|
      %w[daytime 20pm 21pm 22pm].each do |time|
        column = :"group#{group_number}_#{time}_game"
        # nilの時は何もしない、0の時にエラーを追加
        errors.add(column, "は無効な値です") if send(column) == 0
      end
    end
  end
end

