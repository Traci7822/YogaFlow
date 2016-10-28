class Sequence < ActiveRecord::Base
  has_many :sequence_poses
  has_many :poses, through: :sequence_poses
  belongs_to :user
  validates :title, presence: true
  validates :title, uniqueness: true

  def poses_attributes=(poses_attributes)
    poses_attributes.each do |i, pose_attributes|
      binding.pry
      self.poses.build(pose_attributes)
    end
  end
end
