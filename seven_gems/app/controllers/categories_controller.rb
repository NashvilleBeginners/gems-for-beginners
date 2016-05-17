class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully."
      redirect_to categories_path
    else
      flash[:error] = "Category could not be created."
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
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
