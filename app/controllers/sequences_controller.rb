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
    @sequence = Sequence.new
    @sequence.title = params[:sequence][:title]
    @sequence_array = []
    params[:sequence][:pose_ids].each_with_index do |pose_id, i|
      if pose_id != ""
        @sequence_array[i] = Pose.find(pose_id.to_i)
      end
    end
    params[:sequence][:poses_attributes].each.with_index do |pose, i|
      if pose[1].values.first == "" || pose[1].values.last == ""
      else
        @pose = Pose.create(:name => pose[1].values.first)
        if !@pose.description
          @pose.description = pose[1].values.last
          @pose.save
        end
        @sequence_array[i] = @pose
      end
    end
    @sequence.poses = @sequence_array
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
