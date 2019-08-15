# frozen_string_literal: true

class TicketTransactionsController < ApplicationController
  def index
    render json: current_user.ticket_transactions
  end

  def create
    return render status: :forbidden if repeat_reward? | invalid_sell?

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

  def repeat_reward?
    return false if params[:source] != 'reward'

    last_transaction = current_user
      .ticket_transactions
      .where(source: 'reward').last
    elapsed_time = Time.zone.now.to_i - (last_transaction&.created_at).to_i
    elapsed_time < 30
  end

  def invalid_sell?
    return false if params[:source] != 'sell'
    current_user.ticket_transactions.last.source != 'play'
  end

  def invalid_transaction?
    (current_user.tickets + params[:amount].to_i).negative?
  end

  def render_error
    render json: { id: 'error', message: 'You do not have enough Tickets' },
           status: :unprocessable_entity
  end
end
