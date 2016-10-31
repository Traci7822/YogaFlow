class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #redirecting to login, have it log in and redirect to index
      redirect_to root_path, :notice => "You've successfully signed up!"
    else
      render "sessions/new"
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
