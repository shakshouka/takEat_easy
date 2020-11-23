class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :num_of_members, :integer
    add_column :users, :address, :string
    add_column :users, :list_of_restrictions, :text, array: true, default: []
  end
end
