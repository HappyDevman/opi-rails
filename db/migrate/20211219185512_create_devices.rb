class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.integer :device_id
      t.float :battery_level
      t.datetime :published_at
      t.timestamps
    end
  end
end
