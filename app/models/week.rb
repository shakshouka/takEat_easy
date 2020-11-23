class Week < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_many :grocerylists
end
