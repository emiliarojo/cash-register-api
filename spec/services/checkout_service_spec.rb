require 'rails_helper'

RSpec.describe CheckoutService do
  describe '#checkout' do
    let(:basket) { Basket.create! }
    let(:green_tea) { Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11, bogo_eligible: true) }
    let(:strawberries) { Product.create!(code: 'SR1', name: 'Strawberries', price: 5.00, bulk_eligible: true, bulk_threshold: 3, new_price: 4.50) }
    let(:coffee) { Product.create!(code: 'CF1', name: 'Coffee', price: 11.23, bulk_eligible: true, bulk_threshold: 3, discount_factor: 2/3.0) }

    before do
      # Prepare basket items
      basket.basket_items.create!(product: green_tea, quantity: 2, discount_price: 3.11, paid_quantity: 1)  # BOGO will make one free
      basket.basket_items.create!(product: strawberries, quantity: 3, discount_price: 4.50, paid_quantity: 3)  # Price drops to 4.50 each
      basket.basket_items.create!(product: coffee, quantity: 2, discount_price: 11.23, paid_quantity: 2)  # Price doesn't change

      # Stubbing the discount service to prevent actual discount logic in this test
      allow_any_instance_of(DiscountService).to receive(:apply_discounts).and_return([
        "BOGO discount applied to Green Tea: Buy one get one free.",
        "Bulk discount on Strawberries applied: €4.50 each.",
      ])
    end

    it 'correctly calculates the total and prepares itemized receipt with discount messages' do
      checkout_service = CheckoutService.new(basket)
      result = checkout_service.checkout

      expect(result[:total]).to be_within(0.01).of(3.11 + (4.50 * 3) + (11.23 * 2))
      expect(result[:items].size).to eq(3)
      expect(result[:discounts]).to include(
        "BOGO discount applied to Green Tea: Buy one get one free.",
        "Bulk discount on Strawberries applied: €4.50 each."
      )
      expect(result[:items]).to include(
        hash_including(
          product_name: 'Green Tea',
          quantity: 2,
          discount_price: "3.11"
        ),
        hash_including(
          product_name: 'Strawberries',
          quantity: 3,
          discount_price: "4.50"
        ),
        hash_including(
          product_name: 'Coffee',
          quantity: 2,
          discount_price: "11.23"
        )
      )
    end
  end
end
