class LawyersController < ApplicationController
  before_action :set_lawyer, only: [:show, :edit, :update, :destroy]

  def index
    @lawyers = Lawyer.all

    if params[:query].present?
      @lawyers = @lawyers.search_by_name_email_phone(params[:query])
    end

    if params[:category].present?
      @lawyers = @lawyers.where(category_id: params[:category])
    end

    @lawyers = @lawyers.includes(:category).order(created_at: :desc).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.csv do
        attrs = export_attributes
        service = ExportFormatService.new(@lawyers, attrs[:attributes], attrs[:title])
        send_data service.generate_csv, filename: "lawyers-#{Date.today}.csv"
      end
      format.xlsx do
        attrs = export_attributes
        service = ExportFormatService.new(@lawyers, attrs[:attributes], attrs[:title])
        send_data service.generate_xlsx, filename: "lawyers-#{Date.today}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end      
  end

  def show;end

  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(lawyer_params)
    if @lawyer.save
      @lawyer.add_role("lawyer")  
      redirect_to lawyers_path, notice: 'Lawyer was successfully created.'
    else
      render :new
    end
  end

  def edit;end

  def update
    if @lawyer.update(lawyer_params)
      redirect_to lawyers_path, notice: 'Lawyer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lawyer.destroy
    redirect_to lawyers_path, notice: 'Lawyer was successfully deleted.'
  end

  private

  def lawyer_params
    params.require(:lawyer).permit(:name, :email, :gender, :phone, :address, :category_id, :city, :zipcode, :active, :password, :password_confirmation, :team_id, :created_at, :updated_at)
  end

  def set_lawyer
    @lawyer = Lawyer.find(params[:id])
  end

  def export_attributes
   {
    attributes: ['name', 'email', 'phone', 'created_at'],
    title: ['Clients']
   }
  end


end