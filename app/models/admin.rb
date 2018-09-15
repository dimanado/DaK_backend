# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ActiveRecord::Base
  def password_hash(password)
    BCrypt::Password.create(password)
  end

  def test_password(password, hash)
    BCrypt::Password.new(hash) == password
  end
end
