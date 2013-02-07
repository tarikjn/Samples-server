class Redeem < ActiveRecord::Base
  belongs_to :product, :foreign_key => "product_id", :class_name => "Campaign"
  belongs_to :user
  # attr_accessible :title, :body
end
