class CookbookRecipesController < ApplicationController

  def create
    @cookbookrecipe = CookbookRecipe.new(cookbook_id: 1, recipe_id: params[:recipe_id])
    @recipe = Recipe.find(params[:recipe_id])
    authorize @cookbookrecipe
    if @cookbookrecipe.save
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @cookbookrecipe = CookbookRecipe.find_by(recipe_id: params[:id])
    @cookbookrecipe.delete
    authorize @cookbookrecipe
    respond_to do |format|
      format.html
      format.js
    end
  end
end
