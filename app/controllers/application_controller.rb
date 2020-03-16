class ApplicationController < ActionController::Base
  def logged_in?
    unless session[:user_id]
      redirect_to root_path
    end
  end

  def current_user
    unless session[:user_id]
      redirect_to root_path
    else
      User.find(session[:user_id])
    end
  end
end
