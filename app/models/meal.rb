class Meal < ApplicationRecord
  belongs_to :week
  belongs_to :recipe

  validates :moment, presence: true, inclusion: { in: %w[petit-dejeuner dejeuner diner] }
  
end
