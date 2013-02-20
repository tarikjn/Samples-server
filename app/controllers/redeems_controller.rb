class RedeemsController < ApplicationController
  before_filter :restrict_access, :only => [:create, :index]
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

        render json: { time: @redeem.created_at }, status: :created
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

  # GET /campaign/:campaign_id/redeems/people
  def people
    @campaign = Campaign.find(params[:campaign_id])
    @redeems = @campaign.redeems
  end

  # GET /campaign/:campaign_id/redeems/stats
  def stats

  end
end
