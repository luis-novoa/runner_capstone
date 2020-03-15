class UsersController < ApplicationController
  def new
    @user = User.new
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
    @user = User.find(session[:user_id])
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
