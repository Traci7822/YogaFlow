module Sessionable
  def set_session
    session[:user_id] = @user.id
  end
end
