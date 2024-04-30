class BasketsController < ApplicationController
  before_action :set_basket, only: [:show, :destroy, :checkout]

  #GET /baskets
  # List all baskets
  def index
    @baskets = Basket.all
    render json: @baskets
  end

  # POST /baskets
  # Create or find a basket and link it to a session
  def create
    logger.info "Existing session ID: #{session[:session_id]}"  # Log the existing session ID if any
    session[:session_id] ||= SecureRandom.uuid
    logger.info "Assigned session ID: #{session[:session_id]}"  # Log the new or existing session ID

    @basket = Basket.find_or_create_by(session_id: session[:session_id])
    if @basket.save
      render json: { basket_id: @basket.id, session_id: session[:session_id] }, status: :created
    else
      render json: @basket.errors, status: :unprocessable_entity
    end
  end


  # GET /baskets/:id
  # Shows details of a specific basket.
  def show
    render json: @basket
  end

  # DELETE /baskets/:id
  # Deletes a specific basket.
  def destroy
    @basket.destroy
    head :no_content
  end

  # POST /baskets/:id/checkout
  # Checkout the basket.
  def checkout
    checkout_service = CheckoutService.new(@basket)
    result = checkout_service.checkout
    render json: {
      total: format('%.2f', result[:total]),
      items: result[:items],
      discounts: result[:discounts]
    }
  end

  private

  def set_basket
    @basket = Basket.find(params[:id])
  end
end
