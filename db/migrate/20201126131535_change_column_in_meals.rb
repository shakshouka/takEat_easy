class ChangeColumnInMeals < ActiveRecord::Migration[6.0]
  def change
    change_column :meals, :day, :string
  end
end
