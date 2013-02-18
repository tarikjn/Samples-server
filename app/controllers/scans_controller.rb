class ScansController < ApplicationController
  before_filter :restrict_access
  respond_to :json
  skip_before_filter :verify_authenticity_token

  # POST /scans
  # POST /scans.json
  def create
    # save scan not matter what
    @scan = Scan.new(:barcode => params[:barcode])
    @scan.user = @current_user
    @scan.save

    @product = Campaign.find_by_barcode(params[:barcode])

    if @product
      @redeem = Redeem.where(:user_id => @current_user.id, :product_id => @product.id).first
      status = @redeem ? 403 : 200

      # TODO: replace w/ redirect to @product
      render json: @product, status: status
    else
      render :nothing => true, :status => 404
    end
  end
end
