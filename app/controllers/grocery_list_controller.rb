class GroceryListController < ApplicationController
  def show
    @week = Week.last
    @grocery_list = GroceryList.find_by(week_id: @week.id)
    @grocery_items = @grocery_list.grocery_items
    authorize @grocery_list
  end

  def update
    # params["grocery_list"]["grocery_items_attributes"].each do |i|
    #   @id = i[1]["id"].to_i
    #   @grocery_item = GroceryItem.find(@id)
    #   @grocery_item.update()
    #   raise
    #   if i[1][:bought] == 1
    #     @grocery_item.bought = true
    #   end
    #   @grocery_item.save
    # end
    # redirect_to '/weeks/2/grocery_list/1'

  end

  private

  def set_params
    params.require(:grocery_list).permit(:week_id, :bought)
  end
end
