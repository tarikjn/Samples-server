class RedeemsController < ApplicationController
  before_filter :restrict_access
  respond_to :json
  skip_before_filter :verify_authenticity_token

  # POST /redeems
  def create
    @product = Campaign.active.find(params[:product_id])

    if @product
      @prev_redeem = Redeem.where(:user_id => @current_user.id, :product_id => @product.id).first
      if @prev_redeem
        render nothing: true, status: 403
      else
        @redeem = Redeem.new
        @redeem.user = @current_user
        @redeem.product = @product
        @redeem.save

        render nothing: true, status: :created
      end
    else
      render nothing: true, :status => 403
    end
  end

  # GET /redeems TODO: order by latest first
  def index
    @redeems = Redeem.where(user_id: @current_user.id).all
    render json: @redeems
  end
end
