class CreateRedeems < ActiveRecord::Migration
  def change
    create_table :redeems do |t|
      t.references :product
      t.references :user

      t.timestamps
    end
    add_index :redeems, :product_id
    add_index :redeems, :user_id
  end
end
