require 'rails_helper'

RSpec.describe DiscountService do
  describe 'Discount application' do
    let(:basket) { create(:basket) }
    let(:green_tea) { create(:product, name: "Green Tea", code: "GR1", price: 3.11, bogo_eligible: true) }
    let(:strawberries) { create(:product, name: "Strawberries", code: "SR1", price: 5.00, bulk_eligible: true, bulk_threshold: 3, new_price: 4.50) }
    let(:coffee) { create(:product, name: "Coffee", code: "CF1", price: 11.23, bulk_eligible: true, bulk_threshold: 3, discount_factor: 2/3.0) }

    it 'applies BOGO discount correctly for Green Tea' do
      basket.basket_items.create(product: green_tea, quantity: 2)
      DiscountService.new(basket).apply_discounts
      item = basket.basket_items.first
      expect(item.discounted_total_price).to eq(3.11)
    end

    it 'applies bulk discount with new price correctly for Strawberries' do
      basket.basket_items.create(product: strawberries, quantity: 3)
      DiscountService.new(basket).apply_discounts
      item = basket.basket_items.first
      expect(item.discounted_total_price).to eq(13.50)
    end

    it 'applies bulk discount with discount factor correctly for Coffee' do
      basket.basket_items.create(product: coffee, quantity: 3)
      DiscountService.new(basket).apply_discounts
      item = basket.basket_items.first
      expect(item.discounted_total_price).to eq(22.46)
    end
  end
end
