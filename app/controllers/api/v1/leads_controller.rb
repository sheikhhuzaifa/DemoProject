class Api::V1::LeadsController < Api::V1::ApiBaseController
  before_action :set_lead, only: %i[show update destroy]

  def index
    leads = Lead.all
    if leads.any?
      render json: leads, status: :ok
    else
      error_serializer = ErrorSerializer.new(title: "Lead Not found", status: :not_found)
      render json: error_serializer.to_h,status: :not_found
    end
  end

  def show
    if @lead
      render json: @lead, status: :ok
    else
      error_serializer = ErrorSerializer.new(title: "Lead Not found", status: :not_found)
      render json: error_serializer.to_h,status: :not_found
    end
  end

  def update
    if @lead.update(lead_params)
      render json: @lead, status: :ok
    else
      error_serializer = ErrorSerializer.new(title: "Lead not Update", status: :unprocessable_entity)
      render json: error_serializer.to_h,status: :unprocessable_entity
    end
  end

  def create
    lead = Lead.new(lead_params)
    if lead.save
      render json: lead, status: :created
    else
      error_serializer = ErrorSerializer.new(title: "Lead not Create", status: :unprocessable_entity)
      render json: error_serializer.to_h,status: :unprocessable_entity
    end
  end

  def destroy
    if @lead.nil?
      error_serializer = ErrorSerializer.new(title: "Lead Not found", status: :not_found)
      render json: error_serializer.to_h,status: :not_found
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
      error_serializer = ErrorSerializer.new(title: "Lead Not found", status: :not_found)
      render json: error_serializer.to_h,status: :not_found
    end
  end


  def lead_params
    params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact,
                                 :platform_used, :test_type, :bd_id, :sale, :sale_date)
  end
end


