# frozen_string_literal: true

class GameSettingsController < ApplicationController
  def show
    render json: GameSetting.last
  end
end
