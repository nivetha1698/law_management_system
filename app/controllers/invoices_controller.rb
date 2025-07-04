class InvoicesController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @invoices = @invoices.includes(:court_case, :issued_to).order(created_at: :desc).page(params[:page]).per(5)
    @invoices = @invoices.search_by_keywords(params[:query]) if params[:query].present?
    @invoices = @invoices.where(due_date: params[:due_date]) if params[:due_date].present?
    @invoices = @invoices.where(status: params[:status]) if params[:status].present?

    respond_to do |format|
      format.html
      format.csv do
        attrs = export_attributes
        service = ExportFormatService.new(@invoices, attrs[:attributes], attrs[:title])
        send_data service.generate_csv, filename: "invoices-#{Date.today}.csv"
      end
      format.xlsx do
        attrs = export_attributes
        service = ExportFormatService.new(@invoices, attrs[:attributes], attrs[:title])
        send_data service.generate_xlsx, filename: "invoices-#{Date.today}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  def show
    @court_cases = CourtCase.all
    @users = User.all
    @services = Service.all

     respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoice_#{@invoice.id}",
               template: "invoices/show.pdf",
               layout: "pdf",
               disposition: "attachment",
               formats: [ :html ]
      end
    end
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
    @court_cases = CourtCase.all
    @users = User.all
    @services = Service.all
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, notice: "Invoice was successfully created."
    else
      @court_cases = CourtCase.all
      @users = User.all
      render :new
    end
  end

  def edit
    @court_cases = CourtCase.all
    @users = User.all
    @services = Service.all
  end

  def update
    @court_cases = CourtCase.all
    @services = Service.all
    if @invoice.update(invoice_params)
      redirect_to invoices_path, notice: "Invoice was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path, notice: "Invoice was successfully deleted."
  end

  def get_issued_user
    court_case = CourtCase.find_by(id: params[:case_id])
    user = court_case&.client

    if user
      render json: { id: user.id, name: user.name }
    else
      render json: {}
    end
  end

  def new_item_field
    @item = InvoiceItem.new
    render partial: "invoice_item_fields", locals: { f: ActionView::Helpers::FormBuilder.new("invoice[invoice_items_attributes][#{params[:index]}]", @item, self, {}) }
  end

   def export_attributes
   {
    attributes: [ "invoice_no", "client_name", "issued_date", "status", "total", "paid", "due_date" ],
    title: [ "Invoices" ]
   }
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:case_id, :issued_to_id, :amount, :status, :issued_at, :due_date,
                                    invoice_items_attributes: [ :id, :item, :service_id, :quantity, :unit_price, :gst, :cgst, :sgst, :total, :_destroy ])
  end
end
