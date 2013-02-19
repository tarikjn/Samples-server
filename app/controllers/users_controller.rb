class UsersController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token

  # PUT /users/1
  # PUT /users/1.json
  def update
    # TODO: wrap into Facebook class?
    fb_response = Facebook.new(params[:facebook_access_token]).get("/me")
    
    # TODO: handle errors, security

    if fb_response.code != 200
      render :nothing => true, :status => 401
    else
      @user = User.find_by_facebook_id(fb_response['id'])

      if @user
        # existing user logging-in
        @user.update_attribute(:facebook_token, params[:facebook_access_token])
        render :nothing => true, :status => 200
      else
        # shinny new user logging-in
        @user = User.create_from_facebook_response(params[:facebook_access_token], fb_response)
        if @user.save
          render :nothing => true, :status => 201
        else
          render :nothing => true, :status => 500
          raise "could not save new user"
        end
      end
    end
  end
end
