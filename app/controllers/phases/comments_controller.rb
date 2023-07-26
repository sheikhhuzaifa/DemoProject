# frozen_string_literal: true

class Phases::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Phase.find(params[:phase_id])
  end
end
