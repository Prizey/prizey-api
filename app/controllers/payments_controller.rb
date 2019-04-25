# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create
    if stripe_payment(purchase_options)['status'] == 'succeeded'
      add_tickets_to_user(purchase_options)
      render json: success_json, status: :created
    else
      render json: error_json, status: :unprocessable_entity
    end
  end

  private

  def purchase_options
    if params[:ticket_choice] == 'easy'
      { amount: 1000, tickets: 10 }
    elsif params[:ticket_choice] == 'medium'
      { amount: 2500, tickets: 25 }
    elsif params[:ticket_choice] == 'hard'
      { amount: 5000, tickets: 50 }
    end
  end

  def stripe_payment(options)
    Stripe::Charge.create(
      amount: options[:amount],
      currency: 'usd',
      source: params[:credit_card_token],
      customer: current_user.stripe_customer_id,
      description: "#{options[:tickets]} Tickets for User #{current_user.email}"
    )
  end

  def add_tickets_to_user(options)
    current_user.ticket_transactions.create(
      amount: options[:tickets]
    )
  end

  def success_json
    { id: 'success', message: 'Your payment was successfully' }
  end

  def error_json
    { id: 'error', message: 'There was an error with your payment' }
  end
end
