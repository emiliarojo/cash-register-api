class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :discount_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  before_save :set_default_discount_price

  private

  def set_default_discount_price
    # Initialize discount price only if it is not already set
    self.discount_price ||= product.price
  end
end
