class ServicesController < ApplicationController
  before_action :set_service, only: [ :edit, :update, :destroy ]

  def index
    @services = Service.order(created_at: :desc).page(params[:page]).per(5)
    @service = Service.new
    @services = @services.search_by_service_name(params[:query]) if params[:query].present?
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to services_path, notice: "Service was successfully created."
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
   if @service.update(service_params)
      respond_to do |format|
        format.html { redirect_to services_path, notice: "Service updated successfully." }
        format.js
      end
   else
      respond_to do |format|
        format.html { render :edit }
        format.js { render :edit }
      end
   end
  end

  def destroy
    @service.destroy
    redirect_to services_path, notice: "Service was successfully deleted."
  end

  def price
    service = Service.find(params[:id])
    render json: { amount: service.amount }
  end


  private

  def service_params
     params.require(:service).permit(:name, :description, :amount)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
