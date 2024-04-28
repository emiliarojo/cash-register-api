class AddPaidQuantityToBasketItems < ActiveRecord::Migration[7.1]
  def change
    add_column :basket_items, :paid_quantity, :integer, default: nil
  end
end
