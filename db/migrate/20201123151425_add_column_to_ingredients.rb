class AddColumnToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :list_of_restrictions, :text, array: true, default: []
  end
end
