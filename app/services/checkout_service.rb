class CheckoutService
  attr_reader :basket

  def initialize(basket)
    @basket = basket
  end

  def checkout
    discount_messages = apply_discounts
    receipt = itemized_receipt
    { items: receipt, discounts: discount_messages, total: calculate_total }
  end

  private

  def apply_discounts
    DiscountService.new(basket).apply_discounts
  end

  def calculate_total
    basket.basket_items.sum { |item| item.discount_price * item.paid_quantity }
  end

  def itemized_receipt
    basket.basket_items.map do |item|
      {
        product_name: item.product.name,
        quantity: item.quantity,
        unit_price: item.product.price,
        discount_price: item.discount_price,
        total_price: item.discount_price * item.paid_quantity,
      }
    end
  end
end
