class Campaign < ActiveRecord::Base
  belongs_to :brand_owner
  attr_accessible :active, :barcode, :product_name, :small_image, :splash_image
end
