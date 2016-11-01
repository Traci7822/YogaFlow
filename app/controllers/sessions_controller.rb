class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create_with_github
    use = User.create_with_omniauth(request.env["omniauth.auth"])
    binding.pry
  end

  def create
    user = User.find_or_create_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect_to root_path
      #:notice => "You are logged in."
    else
      #flash.now.alert = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
    # :notice => "You are logged out."
  end
end
