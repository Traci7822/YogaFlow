class SessionsController < ApplicationController
    include Sessionable

  def new
    @user = User.new
  end

  def create_with_github
    User.create_with_omniauth(request.env["omniauth.auth"])
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      set_session
      redirect_to root_path
    elsif
      @user.nil?
      @user = User.new
      @user.errors[:username] << "was not found"
      render :new
    elsif
      @user.errors[:password] << "is incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end


end
