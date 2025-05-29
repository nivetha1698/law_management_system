class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @q = Client.ransack(params[:q])
    @clients = @q.result(distinct: true).order(created_at: :desc).page(params[:page])      
  end

  def new
     @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      p @client
      @client.add_role("client")  
      redirect_to clients_path, notice: 'Client was successfully created.'
    else
      p @client
      render :new
    end
  end

  def show
  end

  def edit;
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: 'Client was successfully deleted.'
  end

  private

  def client_params
     params.require(:client).permit(:name, :email, :phone, :address, :category_id, :city, :zipcode, :active, :password, :password_confirmation, :created_at, :updated_at)
  end

  def set_client
    @client = Client.find(params[:id])
  end


end