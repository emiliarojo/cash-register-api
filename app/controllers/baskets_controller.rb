class BasketsController < ApplicationController
  before_action :set_basket, only: [:show, :destroy]

  # POST /baskets
  # Create a new basket instance.
  def create
    @basket = Basket.new
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

  private

  def set_basket
    @basket = Basket.find(params[:id])
  end
end
