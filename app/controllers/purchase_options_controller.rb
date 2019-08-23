# frozen_string_literal: true

class PurchaseOptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: PurchaseOption.order(sorting: :asc, price: :asc).limit(3),
           status: :ok
  end
end
