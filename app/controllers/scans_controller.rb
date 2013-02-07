class ScansController < ApplicationController
  before_filter :restrict_access
  respond_to :json

  # POST /scans
  # POST /scans.json
  def create
    # save scan not matter what
    @scan = Scan.new(:barcode => params[:barcode])
    @scan.save

    @product = Campaign.find_by_barcode(params[:barcode])

    if @product
      @redeem = Redeen.where(:user => @current_user, :product => @product)
      status = @redeem ? 403 : 200

      render json: {
          product_name: @product.name,
          small_image: @product.small_image_url,
          splash_image: @product.splash_image_url
        }, status: status
    else
      render :status => 404
    end
  end
end
