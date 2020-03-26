module ApplicationHelper
  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def error_messages
    return unless flash.present?

    errors = content_tag(:ul) do
      flash[:alert].each do |alert|
        concat(content_tag(:li, alert))
      end
    end
    content_tag(:div, errors, class: %w[notification alert-danger])
  end
end
