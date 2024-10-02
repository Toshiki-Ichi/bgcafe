class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :career_id, :integer
    add_column :users, :likes, :string
    add_column :users, :weakness, :string
    add_column :users, :sns, :string
    add_column :users, :note, :text
    add_column :users, :join1, :integer
    add_column :users, :join2, :integer
    add_column :users, :join3, :integer
  end
end