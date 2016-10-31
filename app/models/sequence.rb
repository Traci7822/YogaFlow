class Sequence < ActiveRecord::Base
  has_many :sequence_poses
  has_many :poses, through: :sequence_poses
  has_many :comments
  belongs_to :user
  validates :title, presence: true
  validates :title, uniqueness: true


  def self.hardest_sequence

  end

  def set_poses(params)
    #poses_attributes
    #set_pose_ids
  end

  def poses_attributes=(poses_attributes, arr)
    poses_attributes.each do |i, pose_attributes|
      self.poses.build(pose_attributes)
    end
  end

end
