class AddAttachesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :attaches, :json
  end
end
