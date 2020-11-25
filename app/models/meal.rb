class Meal < ApplicationRecord
  belongs_to :week
  belongs_to :recipe

  validates :moment, inclusion: { in: %w[petit-dejeuner dejeuner diner] }

end
