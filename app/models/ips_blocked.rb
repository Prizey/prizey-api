# frozen_string_literal: true

class IpsBlocked < ApplicationRecord
  validates :user_ip, presence: true
end
