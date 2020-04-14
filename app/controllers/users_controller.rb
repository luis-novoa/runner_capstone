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
    unless session[:user_id]
      redirect_to root_path
      return
    end
    @user = User.find(params[:id])
    return unless @user.respond_to?(:transactions)

    @transactions = if params[:groupless]
                      @user.transactions.where(group_id: nil).order(:created_at).reverse_order
                    else
                      @user.transactions.includes(:group).order(:created_at).reverse_order
                    end
  end

  def index
    if session[:user_id]
      @other_users = User.all.where.not(id: session[:user_id])
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
