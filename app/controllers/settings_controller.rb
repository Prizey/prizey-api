# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    render json: Setting.all
  end
end
