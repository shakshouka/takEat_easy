class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.references :week, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.string :moment
      t.date :day
      t.integer :num_of_members

      t.timestamps
    end
  end
end
