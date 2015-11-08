class CreateAttaches < ActiveRecord::Migration
  def change
    create_table :attaches do |t|
      t.string :filename
      t.references :attachable, polymorphic: true
      t.timestamps null: false
    end
  end
end
