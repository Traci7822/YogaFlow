class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    end
    redirect_to sequences_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
