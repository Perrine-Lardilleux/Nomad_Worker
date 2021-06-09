class WishlistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.user == user
  end

  def create_index?
    record.user == user
  end

  def destroy?
    record.size < 2
    record.first.user == user
  end

  def destroy_wishlist?
    record.size < 2
    record.first.user == user
  end

end
