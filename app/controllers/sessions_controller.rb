class SessionsController < ApplicationController
    include Sessionable

  def new
    @user = User.new
  end

  def create_with_github
    @user = User.find_by(:username => request.env["omniauth.auth"][:info][:nickname])
    if @user.nil?
      session[:user_id] = User.create_with_omniauth(request.env["omniauth.auth"]).id
    else
      set_session
    end
    redirect_to sequences_path
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
