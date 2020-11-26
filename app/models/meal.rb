class Meal < ApplicationRecord
  belongs_to :week
  belongs_to :recipe

  MOMENTS = %w[petit-dejeuner déjeuner diner].freeze

  validates :moment, inclusion: { in: MOMENTS }
end
