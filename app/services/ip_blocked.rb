# frozen_string_literal: true

class IpBlocked
  def self.execute(*args, &block)
    new(*args, &block).execute
  end

  def initialize(**keywords)
    @ip = keywords[:ip]
  end

  def execute
    delete_expired_ips
    { success: true, payload: find_or_create_ip_blocked }
  end

  private

  def delete_expired_ips
    IpsBlocked.where("created_at <= '#{10.minutes.ago}'").delete_all
  end

  def find_or_create_ip_blocked
    blocked = IpsBlocked.find_by(user_ip: @ip)
    create_ip_blocked if blocked.blank?
    blocked.present?
  end

  def create_ip_blocked
    IpsBlocked.create!(user_ip: @ip)
  end
end
