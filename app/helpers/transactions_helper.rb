module TransactionsHelper
  def back_to_group_link
    @group_id = params[:group_id]
    if @group_id
      link_to '', group_path(@group_id), class: 'fas fa-arrow-left'
    else
      link_to '', user_path(current_user), class: 'fas fa-arrow-left'
    end
  end
end
