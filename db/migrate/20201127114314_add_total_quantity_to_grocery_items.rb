class AddTotalQuantityToGroceryItems < ActiveRecord::Migration[6.0]
  def change
    add_column :grocery_items, :total_quantity, :float
  end
end
