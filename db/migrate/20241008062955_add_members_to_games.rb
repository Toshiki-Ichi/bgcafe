class AddMembersToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :require_time_id, :integer
    add_column :games, :capacity_id, :integer
    add_column :games, :played, :integer

  end
end
