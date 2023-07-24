# frozen_string_literal: true

# comment model
class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save
    redirect_to root_path, notice: 'Your Comment was successfully posted'
  end
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
