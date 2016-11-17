class PosesController < ApplicationController
  before_action :find_sequence
  before_action :set_poses

  def list
    @pose = Pose.find(params[:id])
    render plain: @pose
  end

  def index
    #editing a pose moves that pose to end of @sequence.poses
  end

  def show

  end

  def new
    @sequence = Sequence.find(params[:sequence_id])
    @sequence2 = Sequence.new
    @pose = @sequence2.poses.build
  end

  def create
  end

  def update
  end

private

  def find_sequence
    @sequence = Sequence.find(params[:sequence_id])
  end

  def set_poses
    @poses = Pose.all
  end
end
