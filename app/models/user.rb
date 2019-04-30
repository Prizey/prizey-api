# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  after_create :create_stripe_customer
  after_save :update_stripe_infos

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

  private

  def create_stripe_customer
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer['id'])
  end

  def update_stripe_infos
    Stripe::Customer.update(
      stripe_customer_id,
      address: {
        line1: address,
        city: city,
        country: 'USA',
        postal_code: zipcode,
        state: state_province_region
      }
    )
  end
end
