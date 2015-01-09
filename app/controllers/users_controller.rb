class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @pitches = Pitch.all
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
    @pitches = Pitch.all
    @user = User.find(params[:id])
  end

  def update
    @pitches = Pitch.all
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
    else
      redirect_to user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :password, :password_confirmation, :company, :about, :image)
  end
end
