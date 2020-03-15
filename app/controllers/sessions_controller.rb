class SessionsController < ApplicationController
  def create
    @user = User.find_by(user_params)
    session[:user_id] = @user.id
    redirect_to @user
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
