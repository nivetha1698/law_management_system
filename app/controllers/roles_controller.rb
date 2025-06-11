class RolesController < ApplicationController
 before_action :set_role, only: [ :show, :edit, :update, :destroy ]

  def index
   @roles = Role.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
     @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: "Role was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to roles_path, notice: "Role was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: "Role was successfully deleted."
  end

  private

  def role_params
     params.require(:role).permit(:name, :created_at, :updated_at)
  end

  def set_role
    @role = Role.find(params[:id])
  end
end
