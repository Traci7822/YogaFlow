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

  def set_new_sequence_poses(params)
    set_poses(params)
    update_pose_array
    update_number_of_poses
    self.save
  end

  def set_poses(params)
    @sequence_array = []
    params.each do |attribute|
      if attribute[0] == "pose_ids"
        set_pose_ids(attribute[1])
      elsif attribute[0] == "poses_attributes"
        set_new_pose_ids(attribute[1])
      elsif attribute[0] == "pose"
        set_new_pose_ids(attribute[1])
      end
    end
    @sequence_array
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
      if pose.kind_of?(Hash)
        if pose[1].values.first == "" || pose[1].values.last == ""
        else
          @pose = Pose.create(:name => pose[1].values.first, :description => pose[1].values.last)
          @sequence_array[i] = @pose
        end
      else
        if pose[0] && pose[1]
          @pose = Pose.create(:name => pose[0], :description => pose[1])
          @sequence_array[i] = @pose
        end
      end
    end
  end

  def poses_attributes=(poses_attributes)
    poses_attributes.each do |i, pose_attributes|
      if pose_attributes.values.first == "" || pose_attributes.values.last == ""
      else
        self.poses.build(pose_attributes)
      end
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

  def update_pose_array
    self.poses = @sequence_array
  end

  def update_number_of_poses
    self.number_of_poses = self.poses.count
  end

end
