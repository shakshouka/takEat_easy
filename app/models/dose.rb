class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :unit, inclusion: { in: %w[g cl pc] } # grammes, centilitres ou pièce
end