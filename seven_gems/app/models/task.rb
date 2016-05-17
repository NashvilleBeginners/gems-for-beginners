class Task < ActiveRecord::Base

  validates :description, :category_id, presence: true

  belongs_to :user

end
