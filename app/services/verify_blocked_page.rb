# frozen_string_literal: true

class VerifyBlockedPage
  def self.execute(*args, &block)
    new(*args, &block).execute
  end

  def initialize(**keywords)
    @ip_address = keywords[:ip_address]
    @page = keywords[:page]
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
    return true unless page_valid?

    blocked = Blacklist.find_by(ip_address: @ip_address, page: @page)
    blocked = create_ip_blocked if blocked.blank?

    blocked.present? && blocked.created_at < 5.seconds.ago
  end

  def create_ip_blocked
    Blacklist.create!(ip_address: @ip_address, page: @page)
  end

  def page_valid?
    pages = AdminText.find_by(
      field: 'valid_free_game_pages'
    )&.text&.delete(' ')&.split(',')

    return false if pages.blank? && @page
    return true if @page.blank?

    pages.include?(@page)
  end
end
