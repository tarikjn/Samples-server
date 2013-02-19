class Facebook
  include HTTParty
  base_uri 'https://graph.facebook.com'

  def initialize(access_token)
    self.class.default_params :access_token => access_token
  end

  def get(path)
    self.class.get(path)
  end
end
