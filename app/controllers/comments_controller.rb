class CommentsController < ApplicationController
   def create
     @comment = Comment.create(content: params[:comment][:content], sequence_id: params[:sequence_id], user_id: current_user.id)
     @user = current_user.username
     render json: @comment.as_json(include:[:user])
   end
end
