class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new]

  def index
    if params[:query]
      @users = User.where(company:/#{params[:query]}/i)
    else
      @users = User.all.order("created_at DESC")
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id.to_s
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      session.delete(:user_id)
      redirect_to users_path
    else
      redirect_to user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :password, :password_confirmation, :company, :about, :avatar)
  end
end
