# frozen_string_literal: true

class FreegameIpsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    render status: :created, json: { ip_blocked: ip_blocked }
  end

  private

  def ip_blocked
    IpBlocked.execute(ip: params[:ip])[:payload]
  end
end
