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
    authorize @meal
    if @meal.update(set_params)
      redirect_to meal_path(@meal)
    else
      render :edit
    end
  end

  private

  def set_params
    params.require(:meal).permit(:moment,:day,:num_of_members)
  end
end
