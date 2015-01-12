class PitchesController < ApplicationController
  def index
    if params[:q]
      @pitches = Pitch.where(title:/#{params[:q]}/i)
    else
      @pitches = Pitch.all.order("created_at DESC")
    end
  end

  def new
    @pitch = Pitch.new
  end

  def create
    @pitch = Pitch.new(pitch_params)
    @pitch.user = current_user
    if @pitch.save
      redirect_to pitch_path(@pitch)
    else
      render 'new'
    end
  end

  def show
    @pitch = Pitch.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @pitch = Pitch.find(params[:id])
  end

  def update
    @pitch = Pitch.find(params[:id])
    if @pitch.update_attributes(pitch_params)
      redirect_to pitch_path(@pitch)
    else
      render 'edit'
    end
  end

  def destroy
    @pitch = Pitch.find(params[:id])
    if @pitch.destroy
      redirect_to pitches_path
    else
      redirect_to pitch_path(@pitch)
    end
  end

  private
  def pitch_params
    params.require(:pitch).permit(:title, :description, :image, :user)
  end
end
