class WeeksController < ApplicationController
  def index
    @weeks = policy_scope(Week).order(created_at: :desc)
  end

  def show
    @week = Week.find(params[:id])
    authorize @week
  end

  def new
    @week = Week.new
    authorize @week
  end

  def create
    @week = Week.new(set_params)
    @user = current_user
    @week.user_id = @user.id
    authorize @week
    if @week.save
      empty_meals
      redirect_to week_meals_path(@week)
    else
      render :new
    end
  end

  def edit
    @week = Week.find(params[:id])
    authorize @week
  end

  def update
    @week = Week.find(params[:id])
    authorize @week
    if @week.update(set_params)
      redirect_to week_path(@week)
    else
      render :edit
    end
  end

  def today
    @week = Week.find(params[:id])
    @today = Date.today
    @meals = Meal.includes(:recipe).where("week_id = ? AND day LIKE ?", @week, @today.strftime('%a %d %b %Y'))
    authorize @meals
  end

  def createlisting
    @week = Week.last
    @grocery_list = GroceryList.new
    @grocery_list.week_id = @week.id
    @grocery_list.save
    authorize @grocery_list
    fill_in_cart
    redirect_to week_grocery_list_path(@grocery_list.week, @grocery_list.id)
  end

  private

  def fill_in_cart
    @meals = Meal.where(week_id: @week.id)
    @doses = []
    @meals.each do |meal|
      @doses << Dose.where(recipe_id: meal.recipe_id)
    end
    @doses.flatten.each do |dose|
      if GroceryItem.find_by(ingredient_id: dose.ingredient_id, grocery_list_id: @grocery_list.id)
        @updating_grocery = GroceryItem.find_by(ingredient_id: dose.ingredient_id)
        @updating_grocery.total_quantity += dose.quantity
        @updating_grocery.save
      else
        GroceryItem.create(grocery_list_id: @grocery_list.id, total_quantity: dose.quantity, unit: dose.unit, ingredient_id: dose.ingredient_id).save
      end
    end
  end

  def empty_meals
    (0..6).to_a.each do |day|
      Meal.new(moment: "Diner", day: (@week.start_day + day).strftime('%a %d %b %Y'), week_id: @week.id, recipe_id: random_recipe.id).save
      if [0,6].member?((@week.start_day + day).wday)
        Meal.new(moment: "Déjeuner", day: (@week.start_day + day).strftime('%a %d %b %Y'), week_id: @week.id, recipe_id: random_recipe.id).save
      else
        Meal.new(moment: "Déjeuner", day: (@week.start_day + day).strftime('%a %d %b %Y'), week_id: @week.id, recipe_id: 1).save
      end
    end
  end

  def set_params
    params.require(:week).permit(:user_id, :start_day)
  end

  def random_recipe
    return Recipe.find(rand(2..Recipe.count))
  end
end
