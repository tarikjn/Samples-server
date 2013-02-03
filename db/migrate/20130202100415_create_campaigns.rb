class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :brand_owner
      t.string :product_name
      t.integer :barcode
      t.string :small_image
      t.string :splash_image
      t.boolean :active

      t.timestamps
    end
    add_index :campaigns, :brand_owner_id
  end
end
