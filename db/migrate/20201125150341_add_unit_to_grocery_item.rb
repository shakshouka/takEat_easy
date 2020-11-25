class AddUnitToGroceryItem < ActiveRecord::Migration[6.0]
  def change
    add_column :grocery_items, :unit, :string
  end
end
