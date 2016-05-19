class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    @category.save
    respond_with @category, location: categories_path
  end

  def edit
  end

  def update
    @category.update(category_params)
    respond_with @category, location: categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :active)
  end
end
