class DiscountService
  def initialize(basket)
    @basket = basket
  end

  # This method applies the appropriate discounts to the basket items
  def apply_discounts
    messages = []
    @basket.basket_items.each do |item|
      messages << apply_bogo_discount(item) if item.product.bogo_eligible?
      messages << apply_bulk_discount(item) if item.product.bulk_eligible?
    end
    messages.compact
  end

  private

  # This method applies the Buy One Get One discount to the item
  def apply_bogo_discount(item)
    return unless item.quantity > 1
    # Calculate how many items are paid
    paid_quantity = (item.quantity / 2) + (item.quantity % 2)
    # Add discount price and paid quantity to the item
    item.update(discount_price: item.product.price, paid_quantity: paid_quantity)
    "BOGO discount applied to #{item.product.name}: Buy one get one free." # BOGO discount message
  end

  # This method applies the bulk discount to the item
  def apply_bulk_discount(item)
    item.update(discount_price: item.product.price, paid_quantity: item.quantity) # By default, no discount

    return unless item.quantity >= item.product.bulk_threshold
    discounted_price = if item.product.new_price.present? # If new price is present, use it
                        item.product.new_price
                      elsif item.product.discount_factor.present? # Otherwise, use discount factor
                        item.product.price * item.product.discount_factor
                      end
    item.update(discount_price: discounted_price.round(2))
    formatted_price = format('%.2f', discounted_price)
    "Bulk discount on #{item.product.name} applied: €#{formatted_price} each." # Bulk discount message
  end
end
