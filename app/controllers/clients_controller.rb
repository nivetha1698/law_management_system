class ClientsController < ApplicationController
  require "csv"

  load_and_authorize_resource

  def index
    @q = Client.ransack(params[:q])
    @clients = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.csv do
        attrs = export_attributes
        service = ExportFormatService.new(@clients, attrs[:attributes], attrs[:title])
        send_data service.generate_csv, filename: "clients-#{Date.today}.csv"
      end
      format.xlsx do
        attrs = export_attributes
        service = ExportFormatService.new(@clients, attrs[:attributes], attrs[:title])
        send_data service.generate_xlsx, filename: "clients-#{Date.today}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  def new
     @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path, notice: "Client was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: "Client was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: "Client was successfully deleted."
  end

  def cases
    client = Client.find(params[:id])
    cases = client.court_cases.select(:id, :title)
    render json: cases
  end

  private

  def client_params
     params.require(:client).permit(:name, :email, :gender, :phone, :address, :category_id, :city, :zipcode, :active, :password, :password_confirmation, :created_at, :updated_at)
  end

  def export_attributes
   {
    attributes: [ "name", "email", "phone", "created_at" ],
    title: [ "Clients" ]
   }
  end
end
