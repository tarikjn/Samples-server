class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :facebook_token
  # TODO: add fb_token update time
end
