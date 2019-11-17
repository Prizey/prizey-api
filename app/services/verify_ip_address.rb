# frozen_string_literal: true

class VerifyIpAddress
  def self.execute(*args, &block)
    new(*args, &block).execute
  end

  def initialize(**keywords)
    @ip_address = keywords[:ip_address]
  end

  def execute
    delete_expired_ips
    { success: true, payload: find_or_create_ip_blocked }
  end

  private

  def delete_expired_ips
    Blacklist.where("created_at <= '#{10.minutes.ago}'").delete_all
  end

  def find_or_create_ip_blocked
    blocked = Blacklist.find_by(ip_address: @ip_address)
    create_ip_blocked if blocked.blank?
    blocked.present?
  end

  def create_ip_blocked
    Blacklist.create!(ip_address: @ip_address)
  end
end
