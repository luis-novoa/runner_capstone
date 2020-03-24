module UsersHelper
  def title
    unless params[:id].to_i == session[:user_id]
      content_tag(:h1, "#{@user.name.upcase} TRACKS")
    else
      if params[:groupless]
        content_tag(:h1, 'MY INDIVIDUAL TRACKS')
      else
        content_tag(:h1, 'ALL MY TRACKS')
      end
    end
  end
end
