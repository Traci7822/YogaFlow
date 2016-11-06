class PosesController < ApplicationController
  before_action :find_sequence

  def index
    find_sequence
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
    binding.pry
  end

  def update
  end

private

  def find_sequence
    @sequence = Sequence.find(params[:sequence_id])
  end
end
