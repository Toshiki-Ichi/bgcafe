class AddGroup22pmToGroupschedules < ActiveRecord::Migration[7.0]
  def change
    add_column :groupschedules, :group2_22pm, :string
    add_column :groupschedules, :group3_22pm, :string
  end
end
