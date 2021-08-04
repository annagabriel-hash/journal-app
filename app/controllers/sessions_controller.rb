class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: 'Login successful'
    else
      flash[:alert] = 'Invalid username or password'
      render :new
    end
  end
end