class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = params[:user_id]
      redirect_to root_path, :notice => "You are logged in."
    else
      flash.now.alert = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', :notice => "You are logged out."
  end
end
