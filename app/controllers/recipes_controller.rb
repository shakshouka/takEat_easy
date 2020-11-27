class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @recipes = policy_scope(Recipe).order(created_at: :desc)
  end

  def show
    @doses = Dose.where(recipe_id: params[:id])
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(set_params)
    authorize @recipe
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def update
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    if @recipe.update(set_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def set_params
    params.require(:recipe).permit(:name, :instructions,
                                  :status, :user_id,
                                  :difficulty, :cooking_time,
                                  photos: [])
  end
end
