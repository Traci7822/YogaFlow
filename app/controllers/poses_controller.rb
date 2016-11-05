class PosesController < ApplicationController
  before_action :find_sequence

  def index
  end

  def show
  end

  def new
    @sequence = Sequence.find(params[:sequence_id])
    @poses = Pose.all
    15.times do
      @pose = @sequence.poses.build
    end
  end

  def update
    binding.pry
  end

private

  def find_sequence
    @sequence = Sequence.find(params[:sequence_id])
  end
end
