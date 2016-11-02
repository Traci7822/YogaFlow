class Sequence < ActiveRecord::Base
  has_many :sequence_poses
  has_many :poses, through: :sequence_poses
  has_many :comments
  belongs_to :user
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :difficulty, presence: true
  validates :repititions, presence: true
  before_save :repeated

  def self.most_poses
    most_poses = Sequence.maximum("number_of_poses")
    Sequence.where(:number_of_poses => most_poses)
  end

  def set_poses(params)
    @sequence_array = []
    params.each do |attribute|
      if attribute[0] == "pose_ids"
        set_pose_ids(attribute[1])
      elsif attribute[0] == "poses_attributes"
        set_new_pose_ids(attribute[1])
      end
    end
    #move these to sequence controller private method so update can push @sequence_array onto @sequence.poses
    self.poses = @sequence_array
    self.number_of_poses = self.poses.count
  end

  def set_pose_ids(attribute)
    attribute.each_with_index do |pose_id, i|
      if pose_id != ""
        @sequence_array[i] = Pose.find(pose_id.to_i)
      end
    end
  end

  def set_new_pose_ids(attribute)
    attribute.each.with_index do |pose, i|
      if pose[1].values.first == "" || pose[1].values.last == ""
      else
        @pose = Pose.create(:name => pose[1].values.first, :description => pose[1].values.last)
        @sequence_array[i] = @pose
      end
    end
  end

  def poses_attributes=(poses_attributes)
    poses_attributes.each do |i, pose_attributes|
        self.poses.build(pose_attributes)
    end
  end

  private

    def repeated
      self.poses.each do |pose|
        pose_count = self.poses.where(:name => pose.name).count
        if pose_count > 1
          @pose = sequence_poses.find_by(:pose_id => pose.id)
          @pose.update(:repeated => true)
          @pose.save
        end
      end
    end

end
