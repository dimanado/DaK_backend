class Subscription < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name , :null => false, :default => "default"
      t.belongs_to :user, index: true
    end
  end
end
