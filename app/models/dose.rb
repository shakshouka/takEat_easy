class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

 # grammes, centilitres ou piece

  def quantity
    self[:quantity]
  end
end
