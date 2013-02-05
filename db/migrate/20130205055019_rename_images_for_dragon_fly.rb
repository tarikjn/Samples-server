class RenameImagesForDragonFly < ActiveRecord::Migration
  def change
    rename_column :campaigns, :small_image, :small_image_uid
    rename_column :campaigns, :splash_image, :splash_image_uid
  end
end
