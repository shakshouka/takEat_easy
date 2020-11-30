class GroceryListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def today?
    true
  end

  def createlisting?
    true
  end

  def update?
    true
  end
end
