class Campaign < ActiveRecord::Base
  #belongs_to :brand_owner
  has_many :redeems, :foreign_key => "product_id"

  attr_accessible :active, :barcode, :product_name, :small_image, :splash_image, :retained_small_image, :small_image_url, :retained_splash_image, :splash_image_url
  image_accessor :small_image do
    after_assign :process_small_image
  end
  image_accessor :splash_image do
    after_assign :process_splash_image
  end

  validates :product_name, :presence => true
  validates :barcode, :presence => true
  # iPhone 5 portrait resolution 640 x 1136
  validates :small_image, :presence => true
  #validates_presence_of :splash_image
  # TODO: cutom validators using :greater_than: http://stackoverflow.com/questions/4416278/min-max-validation
  validates_property :width, :of => :splash_image, :in => (640..10000)
  validates_property :height, :of => :splash_image, :in => (1136..10000)
  validates_property :width, :of => :small_image, :in => (50..10000)
  validates_property :height, :of => :small_image, :in => (50..10000)
  
  before_create :assign_owner

  scope :active, where(:active => true)

  def status_caption
    self.active ? 'active':'inactive'
  end

  # replace by has_many?
  def scans
    Scan.where(barcode: self.barcode).all
  end

  # TODO: add dragonfly class helper to do .convert('-resize 50%')
  def as_json(options = {})
    {
      id: self.id,
      name: self.product_name,
      small_image: self.small_image_url,
      small_image_retina: self.small_image_retina_url,
      splash_image: self.splash_image_url,
      splash_image_retina: self.splash_image_retina_url
    }
  end

  # method to avoid repeating .convert('-resize 50%')
  def small_image_url
    self.small_image.convert('-resize 50%').url
  end
  def small_image_retina_url
    self.small_image.url
  end

  # method to support default images
  def splash_image_url
    self.splash_image ? self.splash_image.convert('-resize 50%').url : '/assets/campaigns/splash_default.jpg'
  end
  def splash_image_retina_url
    self.splash_image ? self.splash_image.url : '/assets/campaigns/splash_default@2x.jpg'
  end

private
  def assign_owner
    self.owner_id = 0
  end

  # TODO: move to lambda, see dragonfly Model doc
  def process_small_image
    small_image.encode!(:png).convert!('-resize 50x50 -gravity center -background none -extent 50x50')
  end

  def process_splash_image
    splash_image.convert!('-resize 640x1136^ -gravity center -crop 640x1136+0+0 +repage').encode!(:jpg)
  end
end
