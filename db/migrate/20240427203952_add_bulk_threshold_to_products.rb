class AddBulkThresholdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :bulk_threshold, :integer
  end
end
