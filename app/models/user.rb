class User < ActiveRecord::Base
  has_secure_password
  has_many :sequences
  has_many :poses, through: :sequences

  validates_confirmation_of :password
  validates_presence_of :username
  validates_uniqueness_of :username

end
