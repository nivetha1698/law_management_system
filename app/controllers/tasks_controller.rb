class TasksController < ApplicationController
  require "csv"

  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @q = Task.includes(:assignee).ransack(params[:q])
    @tasks = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.csv do
        attrs = export_attributes
        service = ExportFormatService.new(@tasks, attrs[:attributes], attrs[:title])
        send_data service.generate_csv, filename: "tasks-#{Date.today}.csv"
      end
      format.xlsx do
        attrs = export_attributes
        service = ExportFormatService.new(@tasks, attrs[:attributes], attrs[:title])
        send_data service.generate_xlsx, filename: "tasks-#{Date.today}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  def new
    @task = Task.new
    @users = User.all
    @court_cases = CourtCase.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      @users = User.all
      @court_cases = CourtCase.all
      render :new
    end
  end

  def show
  end

  def edit
    @court_cases = CourtCase.all
    @users = User.all
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  private

  def task_params
     params.require(:task).permit(:title, :description, :status, :case_id, :due_date, :assigned_to)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def export_attributes
   {
    attributes: [ "case_number", "assignee_name", "title", "description", "status", "due_date" ],
    title: [ "Tasks" ]
   }
  end
end
