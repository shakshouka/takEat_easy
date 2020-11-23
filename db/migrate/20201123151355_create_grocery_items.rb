class CreateGroceryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :grocery_items do |t|
      t.references :grocery_list, null: false, foreign_key: true
      t.string :total_quantity
      t.references :ingredient, null: false, foreign_key: true
      t.boolean :bought

      t.timestamps
    end
  end
end
