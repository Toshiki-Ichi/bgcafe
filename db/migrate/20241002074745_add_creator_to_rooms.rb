class AddCreatorToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :creator_id, :integer
  end
end
