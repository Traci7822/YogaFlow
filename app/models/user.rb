class User < ActiveRecord::Base
  has_secure_password
  has_many :sequences
  has_many :poses, through: :sequences
  has_many :comments

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["name"]
    end
  end
end
