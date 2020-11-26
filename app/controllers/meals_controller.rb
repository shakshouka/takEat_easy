class MealsController < ApplicationController
  def show
    @week = Week.find(params[:week_id])
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def create
    @week = Week.find(params[:week_id])
    @recipe = Recipe.find(params[:recipe_id])
    @meal = Meal.new(set_params)
    @meal.week = @week
    @meal.recipe = @recipe
    authorize @meal
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def update
    @meal = Meal.find(params[:id])
    @recipe = random_recipe
    @meal.recipe_id = @recipe.id
    authorize @meal
    @meal.update(set_params)
    redirect_to week_meals_path
  end

  def index
    @week = Week.find(params[:week_id])
    empty_meals
    @meals = policy_scope(Meal.where(week_id: @week.id)).order(created_at: :desc)
    authorize @meals
  end

  private

  def empty_meals
    (0..6).to_a.each do |day|
      Meal.new(moment: "déjeuner", day: @week.start_day + day, week_id: @week.id, recipe_id: 1).save
      Meal.new(moment: "diner", day: @week.start_day + day, week_id: @week.id, recipe_id: 1).save
    end
  end

  def random_recipe
    return Recipe.find(rand(1..Recipe.count))
  end

  def set_params
    params.require(:meal).permit(:moment,:day,:num_of_members, :week_id, :recipe_id)
  end
end
