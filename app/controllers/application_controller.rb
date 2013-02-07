class ApplicationController < ActionController::Base
  # check that this doesn't pose issues
  protect_from_forgery

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by_facebook_token(token)
    end
  end
end
