class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def after_sign_in_path_for(resource)
    dashboards_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :phone, :gender, :address, :city, :state, :zipcode, :country_id ])
  end
end
