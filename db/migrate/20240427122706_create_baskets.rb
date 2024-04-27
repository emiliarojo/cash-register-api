class CreateBaskets < ActiveRecord::Migration[7.1]
  def change
    create_table :baskets do |t|
      t.decimal :total, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
