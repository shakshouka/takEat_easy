class AddUnitsToDoses < ActiveRecord::Migration[6.0]
  def change
    add_column :doses, :units, :string
  end
end
