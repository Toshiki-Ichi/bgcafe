class RemoveColumnFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :orner, :string
  end
end