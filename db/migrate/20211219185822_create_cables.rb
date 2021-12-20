class CreateCables < ActiveRecord::Migration[6.0]
  def change
    create_table :cables do |t|
      t.belongs_to :device
      t.integer :cable_id
      t.datetime :reading_timestamp
      t.float :temperature_reading, null: false, array: true, default: []
      t.float :humidity_reading, null: false, array: true, default: []
      t.timestamps
    end
  end
end
