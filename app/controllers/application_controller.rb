class ApplicationController < ActionController::Base
  def logged_in?
    redirect_to root_path unless session[:user_id]
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end
end
