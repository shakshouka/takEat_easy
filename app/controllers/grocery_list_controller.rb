class GroceryListController < ApplicationController
  def show
    @grocery_list = GroceryList.find(params[:id])
    authorize @grocery_list
    @grocery_items = GroceryItem.where(grocery_list_id: @grocery_list.id)
  end

  private

  def set_params
    params.require(:grocery_list).permit(:week_id)
  end
end
