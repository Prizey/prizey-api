# frozen_string_literal: true

class FreegameIpsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    render status: :created, json: {
      ip_blocked: ip_blocked,
      page_valid: page_valid?,
      id: 1
    }
  end

  private

  def ip_blocked
    VerifyIpAddress.execute(ip_address: request.remote_ip)[:payload]
  end

  def page_valid?
    pages = AdminText.find_by(
      field: 'valid_free_game_pages'
    )&.text&.delete(' ')&.split(',')

    return false if pages.blank?
    return true if params[:page].blank?

    pages.include?(params[:page])
  end
end
