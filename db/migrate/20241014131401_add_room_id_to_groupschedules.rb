class AddRoomIdToGroupschedules < ActiveRecord::Migration[7.0]
  def change
    add_reference :groupschedules, :room, null: false, foreign_key: true
  end
end