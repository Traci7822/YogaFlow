class SequencesController < ApplicationController
  def index
    @sequences = Sequence.all
    @poses = Pose.all
    @users = User.all
  end

  def new
    @poses = Pose.all
    if current_user
      @sequence = Sequence.new
    else
      redirect_to log_in_path
    end
  end

  def create
    #sequence_params not accepting pose_id
    @sequence = Sequence.new(sequence_params)
    #build @sequence.poses and save to sequence_poses table
    redirect_to sequences_path
  end

  def show
    @sequence = Sequence.find(params[:id])
  end

  private

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, poses_attributes: [:pose_id])
  end
end
