# frozen_string_literal: true

class TicketTransactionsController < ApplicationController
  def index
    render json: current_user.ticket_transactions
  end

  def create
    ticket = current_user.ticket_transactions.create(
      amount: params[:amount]
    )

    render json: ticket.as_json, status: :created
  end
end
