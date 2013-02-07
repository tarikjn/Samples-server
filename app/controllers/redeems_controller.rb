class RedeemsController < ApplicationController
  before_filter :restrict_access
  respond_to :json

  # POST /scans
  # POST /scans.json
  def create
    @product = Campaign.find_by_barcode(params[:barcode])

    if @product
      @prev_redeem = Redeen.where(:user => @current_user, :product => @product)
      if @prev_redeem
        render status: 403
      else
        @redeem = Redeem.new(:user => @current_user, :product => @product)
        @redeem.save

        render status: :created
      end
    else
      render :status => 403
    end
  end
end
