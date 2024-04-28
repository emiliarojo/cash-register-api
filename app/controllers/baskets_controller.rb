class BasketsController < ApplicationController
  before_action :set_basket, only: [:show, :destroy]

  # POST /baskets
  # Create a new basket instance.
  def create
    @basket = find_or_create_basket
    if @basket.save
      render json: @basket, status: :created, location: @basket
    else
      render json: @basket.errors, status: :unprocessable_entity
    end
  end

  # GET /baskets/:id
  # Shows details of specific basket.
  def show
    render json: @basket
  end

  # DELETE /baskets/:id
  # Deletes a specific basket
  def destroy
    @basket.destroy
    head :no_content
  end

  # POST /baskets/:id/checkout
  # Checkout the basket
  def checkout
    basket = Basket.find(params[:id])
    checkout_service = CheckoutService.new(basket)
    result = checkout_service.checkout
    render json: result, status: :ok
  end

  private

  def find_or_create_basket
    Basket.find_or_create_by(session_id: session.id)
  end

  def set_basket
    @basket = Basket.find(params[:id])
  end
end
