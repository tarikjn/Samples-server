class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :barcode
      t.references :user

      t.timestamps
    end
    add_index :scans, :user_id
  end
end
