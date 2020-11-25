class RemoveUnitsFromDoses < ActiveRecord::Migration[6.0]
  def change
    remove_column :doses, :units, :string
  end
end
