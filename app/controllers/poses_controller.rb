class PosesController < ApplicationController
  before_action :find_sequence

  def index
  end

  def show
  end

  def new
    @sequence = Sequence.find(params[:sequence_id])
    @poses = Pose.all
    @pose = @sequence.poses.build
  end

  def update
  end

private

  def find_sequence
    @sequence = Sequence.find(params[:sequence_id])
  end
end
