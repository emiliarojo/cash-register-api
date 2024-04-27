class AddDiscountPriceToBasketItems < ActiveRecord::Migration[7.1]
  def change
    add_column :basket_items, :discount_price, :decimal, precision: 10, scale: 2
  end
end
