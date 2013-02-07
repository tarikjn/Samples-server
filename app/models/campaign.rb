class Campaign < ActiveRecord::Base
  #belongs_to :brand_owner

  validates :product_name, :presence => true
  validates :barcode, :presence => true
  # iPhone 5 portrait resolution 640 x 1136
  validates_property :height, :of => :splash_image, :in => [1136]
  validates_property :width, :of => :splash_image, :in => [640]
  validates_property :width, :of => :small_image, :in => [50]
  validates_property :height, :of => :small_image, :in => [50]

  image_accessor :small_image
  image_accessor :splash_image
  attr_accessible :active, :barcode, :product_name, :small_image, :splash_image, :retained_small_image, :small_image_url, :retained_splash_image, :splash_image_url

  before_create :assign_owner

  def status_caption
    self.active ? 'active':'inactive'
  end

  def scan_count
    0
  end

private
  def assign_owner
    self.owner_id = 0
  end
end
