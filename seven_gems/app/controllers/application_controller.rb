require "application_responder"

class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  self.responder = ApplicationResponder
  respond_to :html
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
