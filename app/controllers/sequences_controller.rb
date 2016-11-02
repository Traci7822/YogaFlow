class SequencesController < ApplicationController
  def index
    @sequences = Sequence.all
    @poses = Pose.all
    @users = User.all
    @longest_sequence = Sequence.most_poses.first
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
    if @sequence.valid?
      @sequence.set_new_sequence_poses(params[:sequence])
      redirect_to sequences_path
    else
      @poses = Pose.all
      render :new
    end
  end

  def show
    @sequence = Sequence.find(params[:id])
    redirect_to sequence_poses_path(@sequence)
  end

  def edit
    @sequence = Sequence.find(params[:id])
    @poses = Pose.all
  end

  def update
    #need to pass pose_attributes of new poses - fix form
    @sequence = Sequence.find(params[:id])
    @sequence.poses << @sequence.set_poses(params[:sequence])
    redirect_to sequence_poses_path(@sequence)
  end

  private

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, :repititions, :pose_ids, poses_attributes: [:name, :description, :pose_ids])
  end

end
