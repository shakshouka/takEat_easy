class AddDescriptionToCookbooks < ActiveRecord::Migration[6.0]
  def change
    add_column :cookbooks, :description, :text
  end
end
