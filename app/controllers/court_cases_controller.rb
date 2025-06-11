class CourtCasesController < ApplicationController
 require "csv"

  before_action :set_court_case, only: [ :show, :edit, :update, :destroy ]

  def index
    @q = CourtCase.ransack(params[:q])
    @court_cases = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
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
  end

  def create
    @court_case = CourtCase.new(court_case_params)
    if @court_case.save
      redirect_to court_cases_path, notice: "Court Case was successfully created."
    else
      @clients = Client.all
      @judges = Judge.all
      @lawyers = Lawyer.all

      Rails.logger.debug @court_case.errors.full_messages

      render :new
    end
  end

  def show
  end

  def edit
    @judges = Judge.all
    @lawyers = Lawyer.all
    @clients = Client.all
  end

  def update
    if @court_case.update(court_case_params)
      redirect_to court_cases_path, notice: "Court Case was successfully updated."
    else
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
                                  :first_hearing_date, :next_hearing_date, :court_no, :judge_id, lawyer_ids: [])
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
