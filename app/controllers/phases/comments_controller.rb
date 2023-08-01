# frozen_string_literal: true

class Phases::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable

    begin
      @commentable = Phase.find(params[:phase_id])
    rescue ActiveRecord::RecordNotFound
      render plain: "Phase not found", status: :not_found
    end
  end
end
