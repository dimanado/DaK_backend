class TasksUsers < ActiveRecord::Migration
  def change
    create_table :tasks_users, id: false do |t|
      t.belongs_to :task, index: true
      t.belongs_to :user, index: true
    end
  end
end
