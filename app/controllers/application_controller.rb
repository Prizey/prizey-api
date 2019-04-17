# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include UserBlockedStatus
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_block_status

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
      keys: %i[fullname address city state_province_region zipcode
               clothing_size shoe_size]
    )
  end
end
