class SequencesController < ApplicationController
  def index
    @sequences = Sequence.all
    @poses = Pose.all
    @users = User.all
  end

  def new
    if current_user
      @sequence = Sequence.new
      15.times do
        @sequence.poses.build
      end
      @poses = Pose.all
    else
      redirect_to log_in_path
    end
  end

  def create
    @sequence = Sequence.create(sequence_params)
    @sequence_array = []

    params[:sequence].each do |param|
      if param[0] == "pose_ids"
        param[1].each_with_index do |pose_id, i|
          if pose_id != ""
            @sequence_array[i] = Pose.find(pose_id.to_i)
          end
        end
      elsif param[0] == "poses_attributes"
        param[1].each.with_index do |pose, i|
          if pose[1].values.first == "" || pose[1].values.last == ""
          else
            @pose = Pose.create(:name => pose[1].values.first)
            @pose.update(:description => pose[1].values.last)
            @sequence_array[i] = @pose
          end
        end
      end
    end

    @sequence.update(
      :number_of_poses => @sequence_array.count,
      :poses => @sequence_array)
    @sequence.save
    redirect_to sequences_path
  end

  def show
    @sequence = Sequence.find(params[:id])
  end

  private

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, :pose_ids, poses_attributes: [:name, :description, :pose_ids])
  end

end
