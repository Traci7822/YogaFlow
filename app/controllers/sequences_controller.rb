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
    params[:sequence][:pose_ids].each do |pose_id|
      if pose_id != ""
        @sequence.poses << Pose.find(pose_id.to_i)
      end
    end
    params[:sequence][:poses_attributes].each do |pose|
      if pose[1].values.first == "" || pose[1].values.last == ""
      else
        @pose = Pose.find_or_create_by(:name => pose[1].values.first)

        if !@pose.description
          @pose.description = pose[1].values.last
        end
        @sequence.poses << @pose
      end
    end
    binding.pry
    #need to create post instance properly and save @sequence
    redirect_to sequences_path
  end

  def show
    binding.pry
    @sequence = Sequence.find(params[:id])
  end

  private

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, :pose_ids, poses_attributes: [:name, :description, :pose_ids])
  end

end
