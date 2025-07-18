class CourtCasesController < ApplicationController
 require "csv"

  load_and_authorize_resource

  def index
    @court_cases

    if params[:query].present?
      @court_cases = @court_cases.search_by_keywords(params[:query])
    end

    if params[:client].present?
      @court_cases = @court_cases.where(client_id: params[:client])
    end
    @court_cases = @court_cases.where(priority: params[:priority]) if params[:priority].present?
    @court_cases = @court_cases.order("next_hearing_date ASC NULLS LAST").page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.csv do
        attrs = export_attributes
        service = ExportFormatService.new(@court_cases, attrs[:attributes], attrs[:title])
        send_data service.generate_csv, filename: "court_cases-#{Date.today}.csv"
      end
      format.xlsx do
        attrs = export_attributes
        service = ExportFormatService.new(@court_cases, attrs[:attributes], attrs[:title])
        send_data service.generate_xlsx, filename: "court_cases-#{Date.today}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  def new
     @court_case = CourtCase.new
     @judges = Judge.all
     @lawyers = Lawyer.all
     @clients = Client.all
     @court_case.documents.build
  end

  def create
    @court_case = CourtCase.new(court_case_params)
    if @court_case.save
      redirect_to court_cases_path, notice: "Court Case was successfully created."
    else
      @clients = Client.all
      @judges = Judge.all
      @lawyers = Lawyer.all

      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @judges = Judge.all
    @lawyers = Lawyer.all
    @clients = Client.all
    @court_case.documents.build
  end

  def update
    if @court_case.update(court_case_params)
      redirect_to court_cases_path, notice: "Court Case was successfully updated."
    else
      p @court_case.errors.full_messages
      @judges = Judge.all
      @lawyers = Lawyer.all
      @clients = Client.all
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @court_case.destroy
    redirect_to court_cases_path, notice: "Court Case was successfully deleted."
  end

  def lawyers
    court_case = CourtCase.find(params[:id])
    lawyers = court_case.lawyers.select(:id, :name)
    render json: lawyers
  end

  private

  def court_case_params
     params.require(:court_case).permit(:title, :description, :status, :case_number, :priority, :workflow_status, :client_id, :category_id,
                                  :first_hearing_date, :next_hearing_date, :court_no, :judge_id, lawyer_ids: [], documents_attributes: [ :id, :_destroy, :uploaded_by_id, files: [] ])
  end

  def set_court_case
    @court_case = CourtCase.find(params[:id])
  end

  def export_attributes
   {
    attributes: [ "case_number", "title", "description", "status", "priority", "next_hearing_date" ],
    title: [ "Court Cases" ]
   }
  end
end
