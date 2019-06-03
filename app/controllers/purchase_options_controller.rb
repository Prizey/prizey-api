# frozen_string_literal: true

class PurchaseOptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: PurchaseOption.limit(3).order(price: :asc), status: :ok
  end
end
