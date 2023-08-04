class Api::V1::LeadsController < Api::V1::ApiBaseController
  include ErrorSerializer
  before_action :set_lead, only: %i[show update destroy]

  def index
    leads = Lead.all
    if leads.any?
      render json: leads, status: :ok
    else
      render json: ErrorSerializer.serialize("Leads not found",404),status: :not_found
    end
  end

  def show
    if @lead
      render json: @lead, status: :ok
    else
      render json: ErrorSerializer.serialize("Lead not found",404),status: :not_found
    end
  end

  def update
    if @lead.update(lead_params)
      render json: @lead, status: :ok
    else
      render json: ErrorSerializer.serialize("Lead not Update",422),status: :unprocessable_entity
    end
  end

  def create
    lead = Lead.new(lead_params)
    if lead.save
      render json: lead, status: :created
    else
      render json: ErrorSerializer.serialize("Lead not Create",422),status: :unprocessable_entity
    end
  end

  def destroy
    if @lead.nil?
      render json: ErrorSerializer.serialize("Lead not found",404),status: :not_found
    else
      @lead.destroy
      render json: { message: "Lead deleted successfully" }, status: :ok
    end
  end

  private

  def set_lead
    begin
      @lead = Lead.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: ErrorSerializer.serialize("Lead not found", 404), status: :not_found
    end
  end


  def lead_params
    params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact,
                                 :platform_used, :test_type, :bd_id, :sale, :sale_date)
  end
end


