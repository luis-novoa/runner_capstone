module ApplicationHelper
  def current_user
    unless session[:user_id]
      redirect_to root_path
    else
      User.find(session[:user_id])
    end
  end

  def error_messages
    if flash.present?
      errors = content_tag(:ul) do
        flash[:alert].each do |alert|
          concat(content_tag(:li, alert))
        end
      end
      content_tag(:div, errors , class: ['notification', 'alert-danger'])
      # <div class="notification alert-danger">
      #   <ul>
      #     flash[:alert].collect do |alert|
      #       <li> alert </li>
      #     end
      #   </ul>
      # </div>
    end
  end
end
