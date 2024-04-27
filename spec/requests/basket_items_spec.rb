require 'rails_helper'

RSpec.describe "BasketItems", type: :request do
  describe "POST /baskets/:basket_id/basket_items" do
    it "adds a new item to the basket" do
      basket = Basket.create!
      product = Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11)

      expect {
        post basket_basket_items_path(basket), params: { basket_item: { product_id: product.id, quantity: 2 } }
      }.to change(basket.basket_items, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /baskets/:basket_id/basket_items/:id" do
    it "updates the item in the basket" do
      basket = Basket.create!
      product = Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11)
      basket_item = basket.basket_items.create!(product: product, quantity: 1)

      put basket_basket_item_path(basket, basket_item), params: { basket_item: { quantity: 3 } }
      expect(response).to be_successful
      basket_item.reload
      expect(basket_item.quantity).to eq(3)
    end
  end

  describe "DELETE /baskets/basket_id/basket_items/:id" do
    it "removes the item from the basket" do
      basket = Basket.create!
      product = Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11)
      basket_item = basket.basket_items.create!(product: product, quantity: 1)

      expect {
        delete basket_basket_item_path(basket, basket_item)
      }.to change(basket.basket_items, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

end
