class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.integer :group_id

      t.timestamps
    end
  end
end
