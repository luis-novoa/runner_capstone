module UsersHelper
  def title
    if params[:groupless]
      content_tag(:h1, 'MY INDIVIDUAL TRACKS')
    else
      content_tag(:h1, 'ALL MY TRACKS')
    end
  end
end
