class DestroyNullFalse < ActiveRecord::Migration[6.0]
  def up
    change_column :comments, :content, :text, null: true
  end

  def down
    change_column :comments, :content, :text, null: false
  end
end
