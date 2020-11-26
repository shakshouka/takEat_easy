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
    authorize @week
    if @week.save
      redirect_to week_path(@week)
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
    @meals = Meal.includes(:recipe).where("week_id = ? AND day = ?", @week, @today)
    authorize @meals
  end

  private

  def set_params
    params.require(:week).permit(:user_id, :start_day)
  end
end
