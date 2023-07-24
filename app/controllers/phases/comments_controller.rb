# frozen_string_literal: true

module Phases
  # phase model
  class CommentsController < CommentsController
    before_action :set_commentable

    private

    def set_commentable
      @commentable = Phase.find(params[:phase_id])
    end
  end
end
