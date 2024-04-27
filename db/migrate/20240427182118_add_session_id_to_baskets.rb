class AddSessionIdToBaskets < ActiveRecord::Migration[7.1]
  def change
    add_column :baskets, :session_id, :string
  end
end
