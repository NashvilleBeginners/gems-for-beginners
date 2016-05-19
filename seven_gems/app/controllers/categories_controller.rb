class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @category.save
      flash[:notice] = "Category created successfully."
      redirect_to categories_path
    else
      flash[:error] = "Category could not be created."
      render :new
    end
  end

  def edit
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category updated successfully."
      redirect_to categories_path
    else
      flash[:error] = "Category couldn't be updated."
      redirect_to :back
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :active)
  end
end
