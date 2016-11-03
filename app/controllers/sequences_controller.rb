class SequencesController < ApplicationController
  before_action :set_poses

  def index
    @sequences = Sequence.all
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
    @sequence = Sequence.create(sequence_params)
    if @sequence.valid?
      @sequence.set_new_sequence_poses(params[:sequence])
      redirect_to sequences_path
    else
      render :new
    end
  end

  def show
    set_sequence
    redirect_to sequence_poses_path(@sequence)
  end

  def edit
    set_sequence
    @sequence2 = Sequence.new
    15.times do
      @sequence2.poses.build
    end
  end

  def update
    set_sequence
    @sequence.update(:repititions => sequence_params[:repititions])
    @sequence.poses << @sequence.set_poses(params[:sequence])
    redirect_to sequence_poses_path(@sequence)
  end

  private

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
