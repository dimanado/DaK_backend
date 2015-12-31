class Images < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file, :null => false
      t.belongs_to :course, index: true
      t.belongs_to :video, index: true
    end
  end
end
