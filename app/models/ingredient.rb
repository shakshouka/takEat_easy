class Ingredient < ApplicationRecord
  has_many :doses
  has_many :grocery_items
end
