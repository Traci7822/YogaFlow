class PosesController < ApplicationController
  before_action :find_sequence

  def index
    #editing a pose moves that pose to end of @sequence.poses
  end

  def show
  end

  def new
    @sequence = Sequence.find(params[:sequence_id])
    @sequence2 = Sequence.new
    @poses = Pose.all
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
end
