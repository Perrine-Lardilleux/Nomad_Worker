class WishlistsController < ApplicationController
   def index
    skip_policy_scope
    @wishlists = Wishlist.all
  end
end
