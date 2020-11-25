class CookbooksController < ApplicationController
  def index
    @cookbooks = policy_scope(Cookbook).order(created_at: :desc)
    authorize @cookbooks
  end

  def show
    @cookbook = Cookbook.find(params[:id])
    authorize @cookbook
  end

  def new
    @cookbook = Cookbook.new
    authorize @cookbook
  end

  def create
    @cookbook = Cookbook.new(set_params)
    authorize @cookbook
    @user = current_user
    @cookbook.user = @user
    if @cookbook.save
      redirect_to cookbook_path(@cookbook)
    else
      render :new
    end
  end

  def edit
    @cookbook = Cookbook.find(params[:id])
    authorize @cookbook
  end

  def update
    @cookbook = Cookbook.find(params[:id])
    authorize @cookbook
    if @cookbook.update(set_params)
      redirect_to cookbook_path(@cookbook)
    else
      render :edit
    end
  end

  def destroy
    @cookbook = Cookbook.find(params[:id])
    authorize @cookbook
    @cookbook.destroy
    redirect_to cookbooks_path
  end

  private

  def set_params
    params.require(:cookbook).permit(:name)
  end
end
