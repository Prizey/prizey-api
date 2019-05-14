# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :check_game_status
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :check_user_block_status, unless: :devise_controller?
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

  def check_user_block_status
    json = {
      id: 'forbidden',
      message: 'Your account is currently blocked, please, contact support.'
    }
    render json: json, status: :forbidden if current_user&.blocked?
  end

  def check_game_status
    return unless GameSetting&.first&.game_blocked?
    json = {
      id: 'Service Unavailable', message: 'The game is closed to maintanance'
    }
    render json: json, status: :service_unavailable
  end
end
