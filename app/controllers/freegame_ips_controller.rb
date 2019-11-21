# frozen_string_literal: true

class FreegameIpsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    render status: :created, json: { ip_blocked: ip_blocked, id: 1 }
  end

  private

  def ip_blocked
    VerifyIpAddress.execute(ip_address: request.remote_ip)[:payload]
  end
end
