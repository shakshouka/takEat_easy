class Meal < ApplicationRecord
  belongs_to :week
  belongs_to :recipe

  MOMENTS = %w[Petit-dejeuner Déjeuner Diner].freeze

  validates :moment, inclusion: { in: MOMENTS }
end
