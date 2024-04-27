class DiscountService
  def initalize(basket)
    @basket = basket
  end

  def apply_discounts
    @basket.basket_items.each do |item|
      apply_bogo_discount(item) if item.product.bogo_eligible?
      apply_bulk_discount(item) if item.product.buklk_eligible?
    end
  end

  private

  def apply_bogo_discount(item)
  end
end
