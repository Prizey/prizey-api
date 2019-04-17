# frozen_string_literal: true

module UserBlockedStatus
  include ActiveSupport::Concern

  def check_user_block_status
    json = {
      id: 'unauthorized',
      message: 'Your account is currently blocked, please, contact support.'
    }
    render status: :unauthorized, json: json if current_user&.blocked?
  end
end
