class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @user = current_user
  end

  def new
    @user = User.new
  end

  def show; end

  def create
   
  end

  def edit; end

  def update
  
  end

  def destroy
   
  end

  private

  def user_params
    
  end

  def set_user
    @user = User.find(params[:id])
  end

end
