class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  UNITS = %w[g cl pc].freeze

  validates :unit, inclusion: { in: UNITS } # grammes, centilitres ou piece
end
