class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_many :cookbookrecipes
  has_many :doses, dependent: :delete_all
  has_many_attached :photos

  validates :name, presence: true, format: { with: /\A[\w\-\s]+\z/,
    message: "only allows alphanumeric" }, length: { minimum: 2 }
  validates :difficulty, presence: true, inclusion: { in: %w[Facile Moyen Difficile] }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :instructions, presence: true, length: { minimum: 30 }

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
