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
        #sets poses added from pre-existing pose choices
        set_pose_ids(attribute[1])
      elsif attribute[0] == "poses_attributes"
        #sets poses created from scratch or typed in
        set_new_pose_ids(attribute[1])
      elsif attribute[0] == "pose" && attribute[1].values.first != "" && attribute[1].values.last != ""
        #adds new poses to the sequence after creation
        set_new_sequence_pose_ids(attribute[1])
      end
    end
    @sequence_array
  end

  def set_pose_ids(attribute)
    attribute.each_with_index do |pose_id, i|
      if pose_id != ""
        #adds pose if valid to the array at the index for the order it was created at
        @sequence_array[i] = Pose.find(pose_id)
      end
    end
  end

  def set_new_pose_ids(attribute)
    attribute.each.with_index do |pose, i|
      if pose[1].values[0] == "" || pose[1].values[1] == ""
      else
        @pose = Pose.find_or_create_by(name: pose[1].values[0])
        if @pose.description == nil
          @pose.description = pose[1].values[1]
          @pose.save
        end
        #adds pose if valid to the array at the index for the order it was created at
        @sequence_array[i] = @pose
      end
    end
  end

  def set_new_sequence_pose_ids(attribute)
    if attribute.values.first && attribute.values.last
      @pose = Pose.find_or_create_by(:name => attribute.values.first)
      if @pose.description == nil
        @pose.description = attribute.values.last
        @pose.save
      end
      #adds pose to the end of the sequence
      @sequence_array << @pose
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

  #checks to see if pose is repeated within the sequence and updates the DB
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
