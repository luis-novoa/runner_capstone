class SessionsController < ApplicationController
  def create
    @user = User.find_by(user_params)
    if @user
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = ["User not found. Click on sign up to create a new user."]
      @user = User.new(user_params)
      render '/users/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
