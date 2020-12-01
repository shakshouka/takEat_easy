class GroceryItemsController < ApplicationController
  def update
    @grocery_item = GroceryItem.find(params[:id])
    authorize @grocery_item
    if @grocery_item.bought == true
      @grocery_item.update(bought: false)
    else
      @grocery_item.update(bought: true)
    end
    redirect_to week_grocery_list_path(@grocery_item.grocery_list.week, @grocery_item.grocery_list)
  end
end
