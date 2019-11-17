# frozen_string_literal: true

class Blacklist < ApplicationRecord
  validates :ip_address, presence: true
end
