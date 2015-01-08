class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.where(email: params[:login][:email]).first
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      redirect_to pitches_path
    else
      flash[:notice] = "Error logging in. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to users_path
  end
end