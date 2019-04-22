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
      blocked: blocked,
      tickets: tickets
    }
  end
  # rubocop:enable Metrics/MethodLength

  def tickets
    ticket_transactions.sum(:amount)
  end

  def first_name
    fullname.split(' ').first
  end

  def last_name
    fullname.split(' ').last
  end
end
