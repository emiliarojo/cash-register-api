class AddDiscountEligibilityToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :bogo_eligible, :boolean
    add_column :products, :bulk_eligible, :boolean
    add_column :products, :new_price, :decimal, precision: 10, scale: 2
    add_column :products, :discount_factor, :decimal, precision: 5, scale: 2
  end
end
