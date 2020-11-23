class GroceryItemsController < ApplicationController
  def update
    @grocery_item = GroceryItem.find(params[:id])
    authorize @grocery_item
  end
end
