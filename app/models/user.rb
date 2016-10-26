class User < ActiveRecord::Base
  has_many :sequences
  has_many :poses, through: :sequences
end
