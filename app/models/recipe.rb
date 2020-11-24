class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_many :cookbookrecipes
  has_many :doses, dependent: :delete_all

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9]*\z/,
    message: "only allows alphanumeric" }, length: { minimum: 2}
  validates :difficulty, presence: true, inclusion: { in: %w(facile moyen difficile) }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :instructions, presence: true, length: { minimum: 100}
end
