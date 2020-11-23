class Meal < ApplicationRecord
  belongs_to :week
  belongs_to :recipe
end
