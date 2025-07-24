class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end
end
