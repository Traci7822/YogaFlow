class CommentsController < ApplicationController
   def create
     @comment = Comment.create(content: params[:comment][:content], sequence_id: params[:sequence_id], user_id: current_user.id)
     redirect_to sequence_poses_path
   end
end
