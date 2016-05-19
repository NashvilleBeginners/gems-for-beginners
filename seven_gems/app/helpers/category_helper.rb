module CategoryHelper
  def category_select_options
    Category.pluck(:name, :id)
  end
end
