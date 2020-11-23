class CreateGroceryLists < ActiveRecord::Migration[6.0]
  def change
    create_table :grocery_lists do |t|
      t.references :week, null: false, foreign_key: true

      t.timestamps
    end
  end
end
