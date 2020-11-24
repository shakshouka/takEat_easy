class Cookbook < ApplicationRecord
  belongs_to :user
  has_many :cookbookrecipes, dependent: :delete_all

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9]*\z/,
    message: "only allows alphanumeric" }, uniqueness: { scope: :user },
    length: { minimum: 2}
end
