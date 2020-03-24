class UsersController < ApplicationController
  def new
    if session[:user_id]
      current_user
      redirect_to @user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    current_user
    if @user.respond_to?(:transactions)
      if params[:groupless]
        @transactions = @user.transactions.where(group_id: nil).order(:created_at).reverse_order
      else
        @transactions = @user.transactions.includes(:group).order(:created_at).reverse_order
      end
    end
  end

  def index
    unless session[:user_id]
      redirect_to root_path
    else
      @all_users = User.all
    end
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
