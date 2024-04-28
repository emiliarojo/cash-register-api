class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :paid_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :discount_price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  before_save :set_default_discount_price
  before_save :initialize_paid_quantity

  private

  def set_default_discount_price
    # Initialize discount price only if it is not already set and product is available
    self.discount_price ||= self.product&.price || 0
  end

  def initialize_paid_quantity
    # Set paid_quantity to quantity if not set
    self.paid_quantity ||= self.quantity
  end
end
