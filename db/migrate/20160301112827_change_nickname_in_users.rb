class ChangeNicknameInUsers < ActiveRecord::Migration
  def change
    change_column :users, :nickname, :string, null: false, unique: true
  end
end
