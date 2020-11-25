class RemoveUnitFromIngredient < ActiveRecord::Migration[6.0]
  def change
    remove_column :ingredients, :unit, :string
  end
end
