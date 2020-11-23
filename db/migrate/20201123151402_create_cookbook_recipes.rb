class CreateCookbookRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :cookbook_recipes do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :cookbook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
