class TasksDecorator < ApplicationDecorator
  delegate_all

  def category
    object.category.try(:name) || "Uncategorized"
  end

  def completed?
    object.complete.present?
  end

end
