class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Account was created successfully'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password)
  end
end