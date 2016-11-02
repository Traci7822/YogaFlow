class UsersController < ApplicationController
  include Sessionable

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_session
      redirect_to root_path
    elsif
      User.find_by(username: @user.username)
      render :new
    else
      @user = User.new
      @user.errors[:signup] << "fields can not be blank"
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
