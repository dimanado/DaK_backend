class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.text :body
      t.references :commentable, polymorphic: true, index: true
      t.integer :root_comment_id

      t.timestamps null: false
    end
  end
end
