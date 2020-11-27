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

  private

  def empty_meals
    (0..6).to_a.each do |day|
      Meal.new(moment: "déjeuner", day: @week.start_day + day, week_id: @week.id, recipe_id: 1).save
      Meal.new(moment: "diner", day: @week.start_day + day, week_id: @week.id, recipe_id: 1).save
    end
  end

  def set_params
    params.require(:week).permit(:user_id, :start_day)
  end
end
