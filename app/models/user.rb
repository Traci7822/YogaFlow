class User < ActiveRecord::Base
  has_secure_password
  has_many :sequences
  has_many :poses, through: :sequences
  has_many :comments

  validates_presence_of :username

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.password = ('0'..'z').to_a.shuffle.first(8).join
    end
  end
end
