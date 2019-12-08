# frozen_string_literal: true

class FreegameController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    render status: :created, json: {
      ip_blocked: blocked_page,
      id: 1
    }
  end

  private

  def blocked_page
    VerifyBlockedPage.execute(
      ip_address: request.remote_ip, page: params[:page]
    )[:payload]
  end
end
