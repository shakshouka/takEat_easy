class DosesController < ApplicationController

  def new
    @dose = Dose.new
    authorize @dose
  end

  def create
    @dose = Dose.new(dose_params)
    authorize @dose
    if @dose.save
      redirect_to recipe_path(@dose.recipe)
    else
      render :new
    end
  end

  private

  def dose_params
    params.require(:dose).permit(:recipe_id, :quantity, :ingredient_id, :unit)
  end
end
