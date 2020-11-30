class CookbookRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :cookbook

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :recipe_id ],
    associated_against: {
      recipe: [ :name ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
