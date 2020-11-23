class CookbookRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :cookbook
end
