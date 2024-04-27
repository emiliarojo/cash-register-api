require 'rails_helper'

RSpec.describe "Baskets", type: :request do
  describe "POST /baskets", type: :request do
    it "creates a new Basket and returns a success response" do
      expect { post baskets_path }.to change(Basket, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /baskets/:id" do
    it "returns a basket" do
      basket = Basket.create!
      get basket_path(basket)
      expect(response).to be_successful
      expect(response.body).to include(basket.id.to_s)
    end
  end

  describe "DELETE /baskets/:id" do
    it "deletes the basket" do
      basket = Basket.create!
      expect { delete basket_path(basket) .to change(Basket, :count).by(-1) }
      expect(response).to have_http_status(:no_content)
    end
  end
end
