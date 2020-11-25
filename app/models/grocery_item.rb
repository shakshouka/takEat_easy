class GroceryItem < ApplicationRecord
  belongs_to :grocery_list
  belongs_to :ingredient

  validates :unit, inclusion: { in: %w[g cl pc] } # grammes, centilitres ou pièce
end
