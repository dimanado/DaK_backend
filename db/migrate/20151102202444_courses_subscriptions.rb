class CoursesSubscriptions < ActiveRecord::Migration
  def change
    create_table :courses_subscriptions, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :subscription, index: true
    end
  end
end
