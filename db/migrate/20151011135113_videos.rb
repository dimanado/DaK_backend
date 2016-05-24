class Videos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video , :null => false
      t.belongs_to :course, index: true
      t.timestamps null: false
    end
  end
end
