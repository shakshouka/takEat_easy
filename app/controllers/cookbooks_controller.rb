class CookbooksController < ApplicationController
  def index
    @cookbooks = Cookbook.all
  end

  def show
    @cookbook = Cookbook.find(params[:id])
  end

  def new
    @cookbook = Cookbook.new
  end

  def create
    @cookbook = Cookbook.new(set_params)
  end

  def edit
    @cookbook = Cookbook.find(params[:id])
  end

  def update
    @cookbook = Cookbook.find(params[:id])
    if @cookbook.update(set_params)
      redirect_to cookbook_path(@cookbook)
    else
      render :edit
    end
  end

  def destroy
    @cookbook = Cookbook.find(params[:id])
    @cookbook.destroy
    redirect_to cookbooks_path
  end

  private

  def set_params
    params.require(:cookbook).permit(:name, :user_id)
  end
end
