class UsersController < ApplicationController
  respond_to :json
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find_by_facebook_token(params[:id])

    if @user
      @user.update_attribute(:facebook_token, params[:id])
      render :status => 200
    else
      @user = User.new(:facebook_token => params[:id])
      @user.save # TODO: handle errors
      render :status => 201
    end
  end
end
