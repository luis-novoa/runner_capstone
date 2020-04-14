class GroupsController < ApplicationController
  def new
    if session[:user_id]
      @group = Group.new
    else
      redirect_to root_path
    end
  end

  def create
    current_user
    @new_group = @user.groups.build(group_params)
    if @new_group.save
      redirect_to groups_path
    else
      flash.now[:alert] = @new_group.errors.full_messages
      @group = @new_group
      render 'new'
    end
  end

  def index
    if session[:user_id]
      @all_groups = Group.all.order(:name)
    else
      redirect_to root_path
    end
  end

  def show
    if session[:user_id]
      @group = Group.find(params[:id])
      @transactions = @group.transactions.includes(:user).order(:created_at).reverse_order
    else
      redirect_to root_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
