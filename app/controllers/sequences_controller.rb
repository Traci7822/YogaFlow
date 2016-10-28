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
    else
      redirect_to log_in_path
    end
  end

  def create
    binding.pry
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
    params.require(:sequence).permit(:title, :difficulty, poses_attributes: [])
  end
end
