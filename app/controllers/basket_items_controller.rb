class BasketItemsController < ApplicationController
  before_action :set_basket
  before_action :set_basket_item, only: [:update, :destroy]

  # POST /baskets/:basket_id/basket_items
  # Adds new item to basket.
  def create
    @basket_item = @basket.basket_items.new(basket_item_params)
    if @basket_item.save
      DiscountService.new(@basket).apply_discounts
      render json: @basket_item, status: :created
    else
      render json: @basket_item.errors, status: :unprocessable_entity
    end
  end

  # PUT /baskets/:basket_id/basket_items/:id
  # Updates item in basket.
  def update
    if @basket_item.update(basket_item_params)
      render json: @basket_item
      DiscountService.new(@basket).apply_discounts
    else
      render json: @basket_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /baskets/:basket_id/basket_items/:id
  # Deletes item in basket.
  def destroy
    @basket_item.destroy
    DiscountService.new(@basket).apply_discounts
    head :no_content
  end

  private

  def set_basket
    @basket = Basket.find(params[:basket_id])
  end

  def set_basket_item
    @basket_item = @basket.basket_items.find(params[:id])
  end

  def basket_item_params
    params.require(:basket_item).permit(:product_id, :quantity)
  end
end
