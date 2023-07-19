class Leads::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Lead.find(params[:lead_id])
  end
end
