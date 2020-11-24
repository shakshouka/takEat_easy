class Cookbook < ApplicationRecord
  belongs_to :user
  has_many :cookbookrecipes, dependent: :delete_all

  validates :name, presence: true, format: { with: /\A[\w\-\s]+\z/,
    message: "only allows alphanumeric" }, uniqueness: { scope: :user },
    length: { minimum: 2}
end
