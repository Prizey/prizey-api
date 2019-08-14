# frozen_string_literal: true

class TicketTransactionsController < ApplicationController
  def index
    render json: current_user.ticket_transactions
  end

  def create
    ticket = current_user.with_lock do
      raise ActiveRecord::Rollback if invalid_transaction?
      create_transaction
    end
    if ticket.present?
      render json: ticket.as_json, status: :created
    else
      render_error
    end
  end

  private

  def create_transaction
    current_user.ticket_transactions.create(
      amount: params[:amount], source: params[:source]
    )
  end

  def invalid_transaction?
    (current_user.tickets + params[:amount].to_i).negative?
  end

  def render_error
    render json: { id: 'error', message: 'You do not have enough Tickets' },
           status: :unprocessable_entity
  end
end
