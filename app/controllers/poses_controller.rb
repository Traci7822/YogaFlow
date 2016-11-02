class PosesController < ApplicationController
  before_action :find_sequence

  def index
  end

  def show
  end

  def new
    @poses = Pose.all
  end

private

  def find_sequence
    @sequence = Sequence.find(params[:sequence_id])
  end
end
