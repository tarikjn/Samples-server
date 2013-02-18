class Redeem < ActiveRecord::Base
  belongs_to :product, :foreign_key => "product_id", :class_name => "Campaign"
  belongs_to :user
  # attr_accessible :title, :body

  def as_json(options = {})
    {
      time: self.created_at,
      product_id: self.product_id
    }
  end
end
