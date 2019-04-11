# frozen_string_literal: true

class GameSettingsController < ApplicationController
  def index
    render json: GameSetting.all
  end
end
