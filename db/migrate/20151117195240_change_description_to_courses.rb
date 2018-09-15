class ChangeDescriptionToCourses < ActiveRecord::Migration
  def change
    change_column :courses, :description, :text#, default: ''
  end
end
