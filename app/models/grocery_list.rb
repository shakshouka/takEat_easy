class GroceryList < ApplicationRecord
  belongs_to :week
  has_many :grocery_items
  accepts_nested_attributes_for :grocery_items
end
