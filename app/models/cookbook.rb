class Cookbook < ApplicationRecord
  belongs_to :user
  has_many :cookbookrecipes, dependent: :destroy_all

  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
end
