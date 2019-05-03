# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create
    if stripe_payment(purchase_option)['status'] == 'succeeded'
      add_tickets_to_user(purchase_option)
      render json: success_json, status: :created
    else
      render json: error_json, status: :unprocessable_entity
    end
  end

  private

  def purchase_option
    PurchaseOption.find(params[:purchase_option_id])
  end

  def card_token
    if params[:credit_card_token].present?
      Stripe::Customer.create_source(
        current_user.stripe_customer_id,
        source: params[:credit_card_token]
      )['id']
    else
      params[:credit_card_source]
    end
  end

  def stripe_payment(options)
    Stripe::Charge.create(
      amount: options.price,
      currency: 'usd',
      customer: current_user.stripe_customer_id,
      source: card_token,
      description: "#{options.ticket_amount} Tickets for User " \
        "#{current_user.email}"
    )
  end

  def add_tickets_to_user(options)
    current_user.ticket_transactions.create(
      amount: options.ticket_amount
    )
  end

  def success_json
    { id: 'success', message: 'Your payment was successful' }
  end

  def error_json
    { id: 'error', message: 'There was an error with your payment' }
  end
end
