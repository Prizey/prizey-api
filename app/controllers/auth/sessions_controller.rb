# frozen_string_literal: true

module Auth
  class SessionsController < DeviseTokenAuth::SessionsController
    include UserBlockedStatus
    before_action :set_resource, only: :create
    before_action :check_user_block_status

    def create
      valid_password = @resource.valid_password?(resource_params[:password])
      valid_request = @resource && params_valid && valid_password

      return render_create_error_bad_credentials unless valid_request

      @client_id, @token = @resource.create_token
      @resource.save
      sign_in(:user, @resource, store: false, bypass: false)

      render_create_success
    end

    private

    def params_valid
      valid_params?(:email, resource_params[:email])
    end

    def set_resource
      @resource = User.find_by!(email: resource_params[:email])
    end
  end
end
