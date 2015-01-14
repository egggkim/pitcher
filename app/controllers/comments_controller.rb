class CommentsController < ApplicationController
  def create
    pitch = Pitch.find(params[:pitch_id])
    pitch_comment = comment_params
    pitch_comment[:commenter] = current_user.first_name
    comment = pitch.comments.create(pitch_comment)
    redirect_to pitch_path(comment.pitch)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
