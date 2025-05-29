class LawyersController < ApplicationController
  before_action :set_lawyer, only: [:show, :edit, :update, :destroy]

  def index
    @q = Lawyer.ransack(params[:q])
    @lawyers = @q.result(distinct: true).order(created_at: :desc).page(params[:page])      
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
      p @lawyer
      render :edit
    end
  end

  def destroy
    @lawyer.destroy
    redirect_to lawyers_path, notice: 'Lawyer was successfully deleted.'
  end

  private

  def lawyer_params
    params.require(:lawyer).permit(:name, :email, :phone, :address, :category_id, :city, :zipcode, :active, :password, :password_confirmation, :team_id, :created_at, :updated_at)
  end

  def set_lawyer
    @lawyer = Lawyer.find(params[:id])
  end


end