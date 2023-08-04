# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :check_user_signed_in, unless: :devise_controller?
  rescue_from   Pundit::NotAuthorizedError, with: :handle_not_authorized
  layout :choose_layout

  private
  def choose_layout
    if controller_name == 'projects' && action_name == 'index'
      'application4'
    else
      'application'
    end
  end
  def check_user_signed_in
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username firstname lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image])
  end

  def handle_not_authorized(_exception)
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end
end
