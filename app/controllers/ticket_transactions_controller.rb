# frozen_string_literal: true

class TicketTransactionsController < ApplicationController
  before_action :check_user_balance, only: :create

  def index
    render json: current_user.ticket_transactions
  end

  def create
    ticket = current_user.ticket_transactions.create(
      amount: params[:amount]
    )

    render json: ticket.as_json, status: :created
  end

  private

  def check_user_balance
    return true if params[:amount].to_i.positive?
    render_error if (current_user.tickets + params[:amount].to_i).negative?
  end

  def render_error
    render json: { id: 'error', message: 'You do not have enough Tickets' },
           status: :unprocessable_entity
  end
end
