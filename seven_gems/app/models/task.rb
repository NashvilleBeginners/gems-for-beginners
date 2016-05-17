class Task < ActiveRecord::Base

  validates :description, :category_id, presence: true

end
