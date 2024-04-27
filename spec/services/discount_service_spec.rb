# spec/services/discount_service_spec.rb
RSpec.describe DiscountService do
  it 'applies BOGO discounts correctly' do
    basket = Basket.create!
    tea = Product.create!(name: 'Green Tea', price: 3.11, bogo_eligible: true)
    basket.basket_items.create!(product: tea, quantity: 2)

    DiscountService.new(basket).apply_discounts
    expect(basket.basket_items.first.discounted_total_price).to eq(3.11)
  end

  it 'applies bulk discounts correctly' do
    basket = Basket.create!
    strawberries = Product.create!(name: 'Strawberries', price: 5.00, bulk_eligible: true, bulk_threshold: 3, bulk_discount_factor: 0.9)
    basket.basket_items.create!(product: strawberries, quantity: 3)

    DiscountService.new(basket).apply_discounts
    expect(basket.basket_items.first.discounted_total_price).to eq(13.5)
  end
end
