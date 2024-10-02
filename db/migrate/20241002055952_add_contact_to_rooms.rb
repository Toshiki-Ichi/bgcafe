class AddContactToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :contact, :string
  end
end
