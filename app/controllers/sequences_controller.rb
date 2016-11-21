class SequencesController < ApplicationController
  before_action :set_poses

  #none of the forms route properly after submission. FIX ME!!!!


  # def show
  #   set_sequence
  #   render json: @sequence
  # end

  def ids
    @ids = Sequence.all.map { |sequence| sequence.id  }
    render json: @ids
  end

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
    #creates a new sequence
    @sequence = Sequence.create(sequence_params)
    if @sequence.valid?
      #sets poses that make up the sequence
      @sequence.set_new_sequence_poses(params[:sequence])
      redirect_to sequences_path
    else
      #renders create new sequence form with errors
      flash[:error] = @sequence.errors
      pose_builder
      render :new
    end
  end

  def show
    set_sequence
    respond_to do |f|
      f.html { render :'/poses/index' }
      f.json { render json: @sequence }
    end
  end

  def edit
    set_sequence
  end

  def update
    set_sequence
    @sequence.update(:repititions => sequence_params[:repititions])
    #updates sequence poses from edit poses form
    @sequence.poses = @sequence.set_poses(params[:sequence])
    redirect_to sequence_poses_path(@sequence)
  end

  def add_pose
    #updates sequence poses from add new pose form
    @sequence = Sequence.find(params[:sequence_id])
    @sequence.poses << @sequence.set_poses(params[:sequence])
    redirect_to sequence_poses_path(@sequence)
  end

  private

  def set_poses
    @poses = Pose.all
  end

  def pose_builder
    #builds pose fields for new/add pose forms
    15.times do
      @sequence.poses.build
    end
  end

  def set_sequence
    @sequence = Sequence.find(params[:id])
  end

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, :repititions, :pose_ids, poses_attributes: [:name, :description, :pose_ids])
  end

end
