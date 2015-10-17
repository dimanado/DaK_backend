class AddNameAndFormatToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :name, :string, null: false
    add_column :videos, :format, :string, null: false
  end
end
