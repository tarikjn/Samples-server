class ApiController < ActionController::Base
  before_filter :restrict_access
  respond_to :json

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by_facebook_token(token)
    end
  end
end
