class Course < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name , :null => false, :default => ""
      t.string :heading
      t.text :description
      t.belongs_to :user, index: true
    end
  end
end
