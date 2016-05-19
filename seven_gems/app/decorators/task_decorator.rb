class TaskDecorator < ApplicationDecorator
  delegate_all

  def category
    object.category.try(:name) || "Uncategorized"
  end

  def completed?
    object.complete.present?
  end

  def complete_link
    if completed?
      "Already done!"
    else
      h.link_to "Complete Task", h.user_task_complete_path(object.user_id, object), class: 'btn btn-success'
    end
  end

  def strikethrough_description?
    "strikethrough" if completed?
  end

  def user
    object.user.try(:username)
  end

end
