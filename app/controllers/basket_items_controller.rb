class BasketItemsController < ApplicationController
  before_action :set_basket
  before_action :set_basket_item, only: [:update, :destroy]

  # POST /baskets/:basket_id/basket_items
  # Adds new item to basket.
  def create
    @basket_item = @basket.basket_items.new(basket_item_params)
    if valid_product?(@basket_item.product_id) && @basket_item.save
      update_discounts
      render json: @basket_item, status: :created
    else
      render json: @basket_item.errors, status: :unprocessable_entity
    end
  end

  # PUT /baskets/:basket_id/basket_items/:id
  # Updates item in basket.
  def update
    if valid_product?(@basket_item.product_id) && @basket_item.update(basket_item_params)
      update_discounts
      render json: @basket_item
    else
      render json: @basket_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /baskets/:basket_id/basket_items/:id
  # Deletes item in basket.
  def destroy
    @basket_item.destroy
    update_discounts
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

  # Validates that the product is one of the predefined allowable products
  def valid_product?(product_id)
    Product.exists?(id: product_id, code: ['GR1', 'SR1', 'CF1'])
  end

  # Update discounts using the DiscountService
  def update_discounts
    DiscountService.new(@basket).apply_discounts
  end
end
