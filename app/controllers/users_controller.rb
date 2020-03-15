class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    unless User.find_by(name: user_params)
      @user.create()
    else

    end
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
