class Scan < ActiveRecord::Base
  belongs_to :user
  attr_accessible :barcode
end
