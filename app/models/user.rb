# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  # rubocop:disable Metrics/MethodLength
  def as_json(_options = {})
    {
      id: id,
      email: email,
      fullname: fullname,
      address: address,
      city: city,
      state_province_region: state_province_region,
      postal_code_zip: postal_code_zip,
      clothing_size: clothing_size,
      shoe_size: shoe_size
    }
  end
  # rubocop:enable Metrics/MethodLength
end
