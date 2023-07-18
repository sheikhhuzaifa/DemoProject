class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  def index
    @leads = Lead.sort_by_client
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @lead = Lead.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @lead = Lead.new(lead_params.merge(bd_id: current_user.id))
    authorize @lead



      if @lead.save
       redirect_to @lead
      else
        render :new
      end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    authorize @lead
    if @lead.update(lead_params)
      redirect_to @lead
    else
      render :edit
    end
  end

  def destroy
    authorize @lead
    lead.destroy ? (redirect_to leads_url, notice: "Lead was successfully destroyed.") : ('asdsadasd')
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact, :platform_used, :comments, :test_type,:bd_id)
  end
end
