class ChangeNicknameOfUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :nickname, :string, null: false
  end
end
