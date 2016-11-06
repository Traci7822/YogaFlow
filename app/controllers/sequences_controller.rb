class SequencesController < ApplicationController
  before_action :set_poses

  def index
    @sequences = Sequence.all
    @users = User.all
  end

  def new
    if current_user
      @sequence = Sequence.new
      pose_builder
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
      flash[:error] = @sequence.errors
      pose_builder
      render :new
    end
  end

  def show
    set_sequence
    redirect_to sequence_poses_path(@sequence)
  end

  def edit
    set_sequence
  end

  def update
    set_sequence
    @sequence.update(:repititions => sequence_params[:repititions])
    binding.pry
    @sequence.poses = @sequence.set_poses(params[:sequence])
    redirect_to sequence_poses_path(@sequence)
  end

  def add_pose
    @sequence = Sequence.find(params[:sequence_id])
    @sequence.poses << @sequence.set_poses(params[:sequence])
    redirect_to sequence_poses_path(@sequence)
  end

  private

  def pose_builder
    15.times do
      @sequence.poses.build
    end
  end

  def set_poses
    @poses = Pose.all
  end

  def set_sequence
    @sequence = Sequence.find(params[:id])
  end

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, :repititions, :pose_ids, poses_attributes: [:name, :description, :pose_ids])
  end

end
