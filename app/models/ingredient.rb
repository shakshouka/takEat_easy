class Ingredient < ApplicationRecord
  has_many :doses
  has_many :groceryitems
end
