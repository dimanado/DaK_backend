class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :course, index: true
      t.string :name, null: false
      t.string :file, null: false
      t.string :format, null: false

      t.timestamps null: false
    end
  end
end
