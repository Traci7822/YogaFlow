class SequencesController < ApplicationController
  def index
    @sequences = Sequence.all
    @poses = Pose.all
    @users = User.all
  end

  def new
    if current_user
      @sequence = Sequence.new
      15.times do
        @sequence.poses.build
      end
      @poses = Pose.all
    else
      redirect_to log_in_path
    end
  end

  def create
    @sequence = Sequence.new
    @sequence.title = params[:sequence][:title]
    params[:sequence][:pose_ids].each do |pose_id|
      if pose_id != ""
        @sequence.poses << Pose.find(pose_id.to_i)
      end
    end
    params[:sequence][:poses_attributes].each do |pose|
      if pose[1].values.first == "" || pose[1].values.last == ""
      else
        @sequence.poses << Pose.new(:name => pose[1].values.first, :description => pose[1].values.last, :id => pose[0].to_i)
      end
    end
    #need to create post instance properly and save @sequence
    redirect_to sequences_path
  end

  def show
    @sequence = Sequence.find(params[:id])
  end

  private

  def sequence_params
    params.require(:sequence).permit(:title, :difficulty, poses_attributes: [:name, :description, :pose_ids])
  end
end

#
# => {"utf8"=>"✓",
#  "authenticity_token"=>
#   "Zk1UpnhAakky3iajOuidJt9zH6jHM1u7DRBlO5ZpgztV+U3VR4M7wmZoPToQ0dnO/dsAh6gWK9YQFnufnNBs0Q==",
#  "sequence"=>
#   {"title"=>"new test sequence",
#    "difficulty"=>"1",
#    "pose_ids"=>["1", "2", "", "", "", "", "", "", "", "", "", "", "", "", ""],
#    "poses_attributes"=>
#     {"0"=>{"name"=>"", "description"=>""},
#      "1"=>{"name"=>"", "description"=>""},
#      "2"=>{"name"=>"dflksjdfklj", "description"=>"kljskjfskdlfjs"},
#      "3"=>{"name"=>"", "description"=>""},
#      "4"=>{"name"=>"", "description"=>""},
#      "5"=>{"name"=>"", "description"=>""},
#      "6"=>{"name"=>"", "description"=>""},
#      "7"=>{"name"=>"", "description"=>""},
#      "8"=>{"name"=>"", "description"=>""},
#      "9"=>{"name"=>"", "description"=>""},
#      "10"=>{"name"=>"", "description"=>""},
#      "11"=>{"name"=>"", "description"=>""},
#      "12"=>{"name"=>"", "description"=>""},
#      "13"=>{"name"=>"", "description"=>""},
#      "14"=>{"name"=>"", "description"=>""}}},
#  "commit"=>"Create Sequence",
#  "controller"=>"sequences",
#  "action"=>"create"}
