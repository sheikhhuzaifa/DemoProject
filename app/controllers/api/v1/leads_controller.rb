class Api::V1::LeadsController < Api::V1::ApiBaseController
  before_action :set_lead, only: %i[show update destroy]
  def index
    leads=Lead.all
    render json: leads, status:200
  end

  def show

    if @lead
      render json: @lead, status:200
    else
      render json: {error: "Not Found"}
    end
  end
  def update

    if @lead.update(lead_params)
      render json: @lead, status:200
    else
      render json: {error: "Not Update"}
    end
  end

  def create
    lead =Lead.new(
      id:lead_params[:id],
      project_name:lead_params[:project_name],
      client_name:lead_params[:client_name],
      client_address:lead_params[:client_address],
      client_email:lead_params[:client_email],
      client_contact:lead_params[:client_contact],
      platform_used:lead_params[:platform_used],
      test_type:lead_params[:test_type],
      bd_id:lead_params[:bd_id],
      sale:lead_params[:sale],
      sale_date:lead_params[:sale_date],
    )
    if lead.save
      render json: lead, status:200
    else
      render json: {error: "Not Create"}
    end
  end
  def destroy
    if @lead.nil?
      render json: { error: "Lead not found" }, status: :not_found
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
      render json: { error: "Lead not found" }, status: :not_found
    end
  end
  def lead_params
    params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact,
                                 :platform_used, :test_type, :bd_id, :sale, :sale_date)
  end

end
