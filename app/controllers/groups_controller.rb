class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @new_group = current_user.groups.build(group_params)
    if @new_group.save
      redirect_to groups_path
    else
      flash.now[:alert] = @new_group.errors.full_messages
      @group = @new_group
      render 'new'
    end
  end

  def index
    @all_groups = Group.all.order(:name)
  end

  def show
    @group = Group.find(params[:id])
    @transactions = @group.transactions.includes(:user).order(:created_at).reverse_order
  end

  private
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
