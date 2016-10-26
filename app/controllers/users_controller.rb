class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, :notice => "You've successfully signed up!"
    end
      render "sessions/new"
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
