# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :ticket_transactions, dependent: :restrict_with_exception

  # rubocop:disable Metrics/MethodLength
  def as_json(_options = {})
    {
      id: id,
      email: email,
      fullname: fullname,
      address: address,
      city: city,
      state_province_region: state_province_region,
      zipcode: zipcode,
      clothing_size: clothing_size,
      shoe_size: shoe_size,
      tickets: ticket_transactions.sum(:amount)
    }
  end
  # rubocop:enable Metrics/MethodLength
end
