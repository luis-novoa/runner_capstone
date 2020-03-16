module ApplicationHelper
  def current_user
    return User.find(session[:user_id])
  end
end
