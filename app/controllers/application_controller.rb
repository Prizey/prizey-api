# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render status: :not_found, json: {
      id: 'not_found',
      message: exception.message
    }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[fullname address city state_province_region postal_code_zip
               clothing_size shoe_size]
    )
  end
end
