class JudgesController < ApplicationController
  before_action :set_judge, only: [ :show, :edit, :update, :destroy ]

  def index
    @judges = Judge.order(created_at: :desc).page(params[:page]).per(5)
    @judges = @judges.search_by_keywords(params[:query]) if params[:query].present?
    @judges = @judges.where(court_name: params[:court]) if params[:court].present?
  end

  def new
     @judge = Judge.new
  end

  def create
    @judge = Judge.new(judge_params)
    if @judge.save
      @judge.add_role("judge")
      redirect_to judges_path, notice: "Judge was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @judge.update(judge_params)
      redirect_to judges_path, notice: "Judge was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @judge.destroy
    redirect_to judges_path, notice: "Judge was successfully deleted."
  end

  private

  def judge_params
     params.require(:judge).permit(:name, :email, :gender, :court_name, :password, :password_confirmation, :created_at, :updated_at)
  end

  def set_judge
    @judge = Judge.find(params[:id])
  end
end
