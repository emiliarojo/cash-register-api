require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:valid_attributes) { { code: 'GR1', name: 'Green Tea', price: 3.11 } }
  let(:invalid_attributes) { { code: nil, name: nil, price: nil } }

  describe "GET /products" do
    it "returns a success response" do
      Product.create! valid_attributes
      get products_path
      expect(response).to be_successful
    end
  end

  describe "GET /products/:id" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get product_path(product)
      expect(response).to be_successful
    end
  end

  describe "POST /products" do
    context "with valid parameters" do
      it "creates a new Product and returns a success response" do
        expect { post products_path, params: { product: valid_attributes } }.to change(Product, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new product" do
        expect { post products_path, params: { product: invalid_attributes } }.to change(Product, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /products/:id" do
    let(:new_attributes) { { name: 'Black Tea', price: 5.00 } }

    it "updates the requested product" do
      product = Product.create! valid_attributes
      put product_path(product), params: { product: new_attributes }
      product.reload
      expect(product.name).to eq('Black Tea')
      expect(product.price).to eq(5.00)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /products/:id" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect { delete product_path(product) }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
