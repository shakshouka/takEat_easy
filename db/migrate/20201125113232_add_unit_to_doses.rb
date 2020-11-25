class AddUnitToDoses < ActiveRecord::Migration[6.0]
  def change
    add_column :doses, :unit, :string
  end
end
