class ChangeDiscountFactorPrecisionInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :discount_factor, :decimal, precision: 10, scale: 6
  end
end
