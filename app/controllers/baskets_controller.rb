class BasketsController < ApplicationController
  before_action :set_basket, only: [:show, :destroy]

  # Create a new basket instance and return it as JSON
  def create
    @basket = Basket.new
    if @basket.save
      render json: @basket, status: :created, location: @basket
    else
      render json: @basket.errors, status: :unprocessable_entity
    end
  end

  # Return specified basket as JSON
  def show
    render json: @basket
  end

  # Delete the specified basket and return a no content respons
  def destroy
    @basket.destroy
    head :no_content
  end

  private

  # Set the basket instance variable to the basket with the specified ID for the show and destroy actions
  def set_basket
    @basket = Basket.find(params[:id])
  end

end
