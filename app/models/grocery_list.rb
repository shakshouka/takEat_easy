class GroceryList < ApplicationRecord
  belongs_to :week
  has_many :groceryitems
end
