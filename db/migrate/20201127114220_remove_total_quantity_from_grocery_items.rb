class RemoveTotalQuantityFromGroceryItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :grocery_items, :total_quantity, :string
  end
end
