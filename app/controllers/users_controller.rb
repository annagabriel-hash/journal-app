class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'Account was created successfully'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @user_tasks_today = @user.tasks.where(due: Date.today.beginning_of_day..Date.today.end_of_day)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password, :password_confirmation)
  end
end