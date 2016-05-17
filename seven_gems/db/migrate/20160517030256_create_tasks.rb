class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :category_id
      t.boolean :complete
    end
  end
end
