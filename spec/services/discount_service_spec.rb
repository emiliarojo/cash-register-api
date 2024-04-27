require 'rails_helper'

RSpec.describe DiscountService do
  before do
    @basket = Basket.create!
    @green_tea = Product.create!(name: "Green Tea", code: "GR1", price: 3.11, bogo_eligible: true)
    @strawberries = Product.create!(name: "Strawberries", code: "SR1", price: 5.00, bulk_eligible: true, bulk_threshold: 3, new_price: 4.50)
    @coffee = Product.create!(name: "Coffee", code: "CF1", price: 11.23, bulk_eligible: true, bulk_threshold: 3, discount_factor: 2/3.0)
  end

  it 'applies BOGO discount correctly for Green Tea' do
    item = @basket.basket_items.create!(product: @green_tea, quantity: 2)
    DiscountService.new(@basket).apply_discounts
    expect(item.reload.discount_price).to be_within(0.01).of(1.56)
  end

  it 'applies bulk discount correctly for Strawberries' do
    item = @basket.basket_items.create!(product: @strawberries, quantity: 3)
    DiscountService.new(@basket).apply_discounts
    expect(item.reload.discount_price).to be_within(0.01).of(4.50)
  end

  it 'applies bulk discount correctly for Coffee' do
    item = @basket.basket_items.create!(product: @coffee, quantity: 3)
    DiscountService.new(@basket).apply_discounts
    expect(item.reload.discount_price).to be_within(0.01).of(7.49)
  end
end
