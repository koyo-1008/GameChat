class AddNullFalseToTables < ActiveRecord::Migration[6.0]
  def up
    change_column :channels, :name, :string, default: "" , null: false
    change_column :channels, :group_id, :integer, null: false
    change_column :comments, :channel_id, :integer, null: false
    change_column :comments, :content, :text, null: false
    change_column :comments, :user_id, :integer, null: false
    change_column :group_users, :user_id, :integer, null: false
    
    change_column :group_users, :group_id, :integer, null: false
    
    change_column :groups, :name, :string, default: "" , null: false
    change_column :users, :name, :string, default: "", null: false
    
    
  end

  def down
    change_column :channels, :name, :string, default: "" , null: true
    change_column :channels, :group_id, :integer, null: true
  end
end
