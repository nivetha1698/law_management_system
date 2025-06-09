class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show_current
    @user = current_user
    @countries = Country.order(:name)
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def show
    @countries = Country.order(:name)
  end


  def edit
  end

  def update
     if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def upload
    if params[:user] && params[:user][:profile_image]
      current_user.profile_image.attach(params[:user][:profile_image])
      redirect_to profile_path, notice: "Profile image uploaded successfully."
    else
      redirect_to profile_path, alert: "Please choose an image to upload."
    end
  end

  def remove
    if current_user.profile_image.attached?
      current_user.profile_image.purge
      redirect_to profile_path, notice: "Profile image removed successfully."
    else
      redirect_to profile_path, alert: "No image to remove."
    end
  end



  private

  def user_params
     params.require(:user).permit(:name, :email, :phone, :country_id, :address, :profile_image, :password, :password_confirmation, :created_at, :updated_at)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
