class AppointmentsController < ApplicationController
  require 'csv'

  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @q = Appointment.includes(:client).ransack(params[:q])
    @appointments = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
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
      redirect_to appointments_path, notice: 'Appointment was successfully created.'
    else
      p @appointment.errors.full_messages
      @clients = Client.all
      render :new
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
      redirect_to appointments_path, notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment was successfully deleted.'
  end

  private

  def appointment_params
     params.require(:appointment).permit(:date, :time, :client_id, :case_id, :lawyer_id,
                                         note_attributes: [:id, :title, :content, :case_id, :lawyer_id, :_destroy])
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def export_attributes
   {
    attributes: ['client_name', 'date', 'time'],
    title: ['Appointments']
   }
  end

end

