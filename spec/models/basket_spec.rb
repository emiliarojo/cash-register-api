require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { should have_many(:basket_items).dependent(:destroy) }
  it { should have_many(:products).through(:basket_items) }

  it 'is valid with valid attributes' do
    basket = Basket.new
    expect(basket).to be_valid
  end
end
