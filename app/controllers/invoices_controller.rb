class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.order(created_at: :desc).page(params[:page]).per(5)
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
               disposition: 'attachment',                   
               formats: [:html]                        
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
      p @invoice.errors.full_messages
      redirect_to invoices_path, notice: 'Invoice was successfully created.'
    else
      p @invoice.errors.full_messages
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
      p @invoice.errors.full_messages
      redirect_to invoices_path, notice: 'Invoice was successfully updated.'
    else
      p @invoice.errors.full_messages
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path, notice: 'Invoice was successfully deleted.'
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
    render partial: 'invoice_item_fields', locals: { f: ActionView::Helpers::FormBuilder.new("invoice[invoice_items_attributes][#{params[:index]}]", @item, self, {}) }
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:case_id, :issued_to_id, :amount, :status, :issued_at, :due_date,
                                    invoice_items_attributes: [:id, :item, :service_id, :quantity, :unit_price, :cgst, :sgst, :total, :_destroy])
  end
end
