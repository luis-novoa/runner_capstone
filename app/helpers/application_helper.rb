module ApplicationHelper
  def current_user
    unless session[:user_id]
      redirect_to root_path
    else
      User.find(session[:user_id])
    end
  end
end
