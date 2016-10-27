class SequencesController < ApplicationController
  def index
    @sequences = Sequence.all
    @poses = Pose.all
    @users = User.all
  end

  def new
    if current_user
    else
      redirect_to log_in_path
    end
  end

  def show
    @sequence = Sequence.find(params[:id])
  end
end
