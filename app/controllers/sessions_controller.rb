class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    binding.pry
    #omniauth request always returning nil
    if auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_path
    else
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
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
    # :notice => "You are logged out."
  end
end
