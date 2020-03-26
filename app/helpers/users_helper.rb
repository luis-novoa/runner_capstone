module UsersHelper
  def title
    if params[:id].to_i == session[:user_id]
      if params[:groupless]
        content_tag(:h1, 'MY INDIVIDUAL TRACKS')
      else
        content_tag(:h1, 'ALL MY TRACKS')
      end
    else
      content_tag(:h1, "#{@user.name.upcase} TRACKS")
    end
  end
end
