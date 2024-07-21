class ApplicationController < ActionController::Base
  impersonates :user
  include Pundit::Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  ActiveStorage::Current.url_options = {host: 'localhost', port: '3000'}

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :user_type])
    end
end
