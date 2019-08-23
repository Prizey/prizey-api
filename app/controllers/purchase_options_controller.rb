# frozen_string_literal: true

class PurchaseOptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    options = PurchaseOption.order(sorting: :asc, ticket_amount: :asc).limit(3)
    render json: options, status: :ok
  end
end
