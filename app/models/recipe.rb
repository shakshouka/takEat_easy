class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_many :cookbookrecipes
  has_many :doses
end
