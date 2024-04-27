class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :product
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
end
