class GroceryListController < ApplicationController
  def create
    @week = Week.find(params[:week_id])
    @grocery_list = GroceryList.new
    @grocery_list.week_id = @week.id
    authorize @grocery_list
    fill_in_cart
    @grocery_list.save
    redirect_to week_grocery_list_path
  end

  def show
    @grocery_list = GroceryList.find(params[:id])
    authorize @grocery_list
    @grocery_items = GroceryItem.where(grocery_list_id: @grocery_list.id)
  end

  private

  def fill_in_cart
    @meals = Meal.where(week_id: @week.id)
    @doses = []
    @meals.each do |meal|
      @doses << Dose.where(recipe_id: meal.recipe_id)
    end
    @doses.flatten.each do |dose|
      if GroceryItem.find_by(ingredient_id: dose.ingredient_id)
        @updating_grocery = GroceryItem.find_by(ingredient_id: dose.ingredient_id)
        @updating_grocery.total_quantity += dose.quantity
        @updating_grocery.save
      else
        GroceryItem.create(grocery_list_id: @grocery_list.id, total_quantity: dose.quantity, unit: dose.unit, ingredient_id: dose.ingredient_id)
      end
  end

  def set_params
    params.require(:grocery_list).permit(:week_id)
  end
end
