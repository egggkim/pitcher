class CommentsController < ApplicationController
  def create
    pitch = Pitch.find(params[:pitch_id])
    comment = pitch.comments.create(comment_params)
    redirect_to pitch_path(comment.pitch)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, commenter_attributes: [:name, :email])
  end
end
