class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user 
      session[:user_id] = user.id
      flash[:notice] = 'Login successful'
      redirect_to user_path(user)
    else
    end
  end
end