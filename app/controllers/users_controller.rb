class UsersController < ApplicationController
  def new
    if session[:user_id]
      @user = current_user
      redirect_to @user
    else
      @user = User.new
    end
  end

  def create
    unless User.find_by(user_params)
      @user = User.create(user_params)
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = 'User exists. Try to log in!'
      @user = User.new(user_params)
      render 'new'
    end
  end

  def show
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
