class PosesController < ApplicationController
  def index
    @sequence = Sequence.find(params[:sequence_id])
  end

  def show
    @sequence = Sequence.find(params[:sequence_id])
  end

  def new
    @sequence = Sequence.find(params[:sequence_id])
    @poses = Pose.all
  end
end
