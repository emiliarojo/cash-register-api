require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    product = Product.new(code: 'GR1', name: 'Green Tea', price: 3.11)
    expect(product).to be_valid
  end

  it 'is not valid without a code' do
    product = Product.new(name: 'Green Tea', price: 3.11)
    expect(product).not_to be_valid
  end

  it 'is not valid without a name' do
    product = Product.new(code: 'GR1', price: 3.11)
    expect(product).not_to be_valid
  end

  it 'is not valid without a price' do
    product = Product.new(code: 'GR1', name: 'Green Tea')
    expect(product).not_to be_valid
  end
end
