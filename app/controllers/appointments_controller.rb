class AppointmentsController < ApplicationController
  require "csv"

  load_and_authorize_resource

  def index
    @appointments = @appointments.includes(:client).order(created_at: :desc).page(params[:page]).per(5)
    @appointments = @appointments.search_by_clients_and_cases(params[:query]) if params[:query].present?
    @appointments = @appointments.where(lawyer_id: params[:lawyer]) if params[:lawyer].present?
    @appointments = @appointments.where(date: params[:date]) if params[:date].present?

    respond_to do |format|
      format.html
      format.csv do
        attrs = export_attributes
        service = ExportFormatService.new(@appointments, attrs[:attributes], attrs[:title])
        send_data service.generate_csv, filename: "appointments-#{Date.today}.csv"
      end
      format.xlsx do
        attrs = export_attributes
        service = ExportFormatService.new(@appointments, attrs[:attributes], attrs[:title])
        send_data service.generate_xlsx, filename: "appointments-#{Date.today}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  def new
    @appointment = Appointment.new
    @appointment.build_note
    @clients = Client.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      attach_new_documents(@court_case)
      redirect_to appointments_path, notice: "Appointment was successfully created."
    else
      @clients = Client.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @clients = Client.all
  end

  def edit
    @clients = Client.all
  end

  def update
    if @appointment.update(appointment_params)
      attach_new_documents(@court_case)
      redirect_to appointments_path, notice: "Appointment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment was successfully deleted."
  end

  private

  def appointment_params
     params.require(:appointment).permit(:date, :time, :client_id, :case_id, :lawyer_id,
                                         note_attributes: [ :id, :title, :content, :case_id, :lawyer_id, :_destroy ])
  end

  def export_attributes
   {
    attributes: [ "no", "client_name", "case", "lawyer", "date", "time" ],
    title: [ "Appointments" ]
   }
  end

  private

  def attach_new_documents(record)
   return unless params[:new_documents]

   params[:new_documents].each do |file|
    doc = record.documents.build(uploaded_by_id: params[:uploaded_by_id], title: file.original_filename)
    doc.files.attach(file)
    doc.save
   end
  end
end
