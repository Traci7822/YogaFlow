class CommentsController < ApplicationController
   def create
     @comment = Comment.create(content: params[:comment][:content], sequence_id: params[:sequence_id], user_id: current_user.id)
     @user = current_user.username
     respond_to do |f|
       f.html { redirect_to sequence_poses_path}
       f.json { render json: @comment}
     end
   end
end
