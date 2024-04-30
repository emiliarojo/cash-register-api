require 'rails_helper'

RSpec.describe 'Checkout Process', type: :request do
  before do
    # Create products directly
    @green_tea = Product.create!(code: 'GR1', name: "Green Tea", price: 3.11, bogo_eligible: true)
    @strawberries = Product.create!(code: 'SR1', name: "Strawberries", price: 5.00, bulk_eligible: true, bulk_threshold: 3, new_price: 4.50)
    @coffee = Product.create!(code: 'CF1', name: "Coffee", price: 11.23, bulk_eligible: true, bulk_threshold: 3, discount_factor: 2/3.0)
    @basket = Basket.create!
  end

  it 'completes a checkout process with discounts' do
    # Add items to the basket
    post "/baskets/#{@basket.id}/basket_items", params: {
      basket_item: { product_id: @green_tea.id, quantity: 2 }
    }
    expect(response).to have_http_status(:created)

    post "/baskets/#{@basket.id}/basket_items", params: {
      basket_item: { product_id: @strawberries.id, quantity: 3 }
    }
    expect(response).to have_http_status(:created)

    post "/baskets/#{@basket.id}/basket_items", params: {
      basket_item: { product_id: @coffee.id, quantity: 2 }
    }
    expect(response).to have_http_status(:created)

    # Perform checkout
    post "/baskets/#{@basket.id}/checkout"
    expect(response).to have_http_status(:ok)

    # Parse the JSON response
    json_response = JSON.parse(response.body)
    expect(json_response['total']).to eq((3.11 + (4.50 * 3) + (11.23 * 2)).to_s)  # String comparison due to JSON parsing
    expect(json_response['discounts']).to include(
      "BOGO discount applied to Green Tea: Buy one get one free.",
      "Bulk discount on Strawberries applied: €4.50 each."
    )
  end
end
